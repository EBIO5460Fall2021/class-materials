#' ---
#' title: Binomial GLM. Swiss breeding bird survey example
#' author: Brett Melbourne
#' date: 16 Nov 2020 (updated 16 Nov 2021)
#' output:
#'     github_document:
#'         pandoc_args: --webtex
#' ---

#' Willow tit distribution with altitude. This is an example of a nonlinear
#' biological model with a binomial distribution. The model is logit-linear and
#' together with the binomial distribution, this combination is the special case
#' of logistic regression. The data are occurrence (presence-absence) of the
#' willow tit. This example is from Royle JA & Dorazio RM (2008) Hierarchical
#' Modeling and Inference in Ecology, p 87. Altitude data are from
#' eros.usgs.gov. To exactly replicate the analysis on p 87, first rescale the
#' elevation data: `elev <- scale(elev)`. I don't do that here in order to show
#' another strategy for fixing an algorithm, i.e. rescaling parameters.
#' 

#+ message=FALSE, warning=FALSE
library(ggplot2)
library(dplyr)
theme_set(theme_bw())

#' Read in and plot elevation data (digital elevation model) for Switzerland. 
swissdem <- read.csv("data/switzerland_tidy.csv")

ggplot(swissdem) +
    geom_raster(aes(x=x, y=y, fill=Elev_m)) +
    scale_fill_gradientn(colors=terrain.colors(22), name="Elevation (m)") + 
    coord_quickmap() +
    labs(title="Switzerland: DEM") +
    theme_void() +
    theme(plot.title=element_text(hjust=0.5, vjust=-2))
    

#' Read in the bird data. The dataset is from Royle & Dorazio. We will focus for
#' now on the occurrence data from year 1 in the column `y.1`.
willowtit <- read.csv("data/wtmatrix.csv") 

#' Here's the first 30 rows of data
willowtit %>% 
    select(y.1,elev) %>% 
    head(n=30)
    

#' Plot the data 
ggplot(willowtit) +
    geom_jitter(aes(x=elev, y=y.1), shape=1, size=2, height=0.01) +
    labs(x="Elevation (m)", 
         y="Occurrence", 
         title="Occurrence of willow tit in Switzerland")


#' ... also summarized by binning into 500 m increments. We set up bins, then
#' calculate the proportion present in each bin, then the midpoint of the bin.
#' The mean of a binary variable (0,1) is the proportion.
freq_table <-
    willowtit %>% 
    group_by(bin=cut(elev, breaks=seq(0, 3000, by=500))) %>% 
    summarize(p=mean(y.1)) %>% 
    mutate(mid=seq(250, 3000, by=500)) 
freq_table

#' Plot including the binned proportion and a smoother on the occurrence data
#' (i.e. the zeros and ones) for comparison
ggplot() +
    geom_jitter(data=willowtit, aes(x=elev, y=y.1), shape=1, size=2, height=0.01) +
    geom_smooth(data=willowtit, aes(x=elev, y=y.1), size=0.5, se=FALSE) +
    geom_line(data=freq_table, aes(x=mid, y=p), col=2) +
    geom_point(data=freq_table, aes(x=mid, y=p), shape=1, size=2, col=2) +
    coord_cartesian(ylim=c(-0.01,1.01)) +
    labs(x="Elevation (m)", 
         y="Occurrence (or proportion)", 
         title="Relationship appears humped")


#' ## Binomial GLM the hard way
#'
#' We'll first do this the hard way by coding the likelihood and optimizing
#' directly. I'm doing this to show the structure of the analysis and the
#' general algorithm. You won't do this for ordinary binomial GLMs like this
#' example because you can use `glm()` that does the same thing and `stan_glm()`
#' for the Bayesian version with sensible priors (see further below).
#' 

#' ### The linear predictor
#'
#' Here we'll allow for the distribution of willow tits with elevation to be
#' hump shaped. There is an optimal elevation for willow tits. To model a hump,
#' we relate the logit of the probability of occurrence, p, to elevation by a
#' quadratic function:
#'
#' $$ln( p/(1-p) ) = \beta_0 + \beta_1 elev + \beta_2 elev^2$$
#'
#' The probability of occurrence of the willow tit for a sample location is then
#' obtained from the inverse function of the linear predictor, in this case the
#' antilogit. Notice that the logit link function ranges from -INF to +INF on
#' the scale of the linear predictor but is bounded 0-1 on the probability
#' scale. This function is calculating the predicted probability.
#' 
p_pred_quadratic  <- function(b0, b1, b2, elev) {
    lp <- b0 + b1 * elev + b2 * elev^2   #logit p
    prob <- exp(lp) / (1 + exp(lp))      #antilogit
    return(prob)
}

#' ### Negative log likelihood function
#'
#' ... for logit-quadratic model with binomial distribution. A log scale direct
#' search showed that $\beta_2$ is several orders of magnitude smaller than the
#' other parameters. Optimization is better behaved if all parameters are on
#' similar scales. We use a simple trick here, which is to pass `quadratic_nll`
#' a parameter with a similar magnitude to the other parameters but then rescale
#' the parameter in the `quadratic_nll` function back to its original magnitude.
#' 
quadratic_nll <- function(p, occ, elev) {
	b2 <- p[3] * 1e-06  #Rescale
    ppred <- p_pred_quadratic(b0=p[1], b1=p[2], b2, elev)
    nll <- -sum(dbinom(occ, size=1, prob=ppred, log=TRUE))
    return(nll)
}

#' I first did a bit of a grid search to get some idea of the likelihood surface
#' and that suggested these starting values for `optim()`.
par <- c(-8,0.02,-3)

#' Now find the MLE using `optim()` with the Nelder-Mead algorithm
fit_quadratic <- optim(par, quadratic_nll, occ=willowtit$y.1, elev=willowtit$elev)

#' Here are the results of the fit. $\beta_2$ is `par[3]*1e-06`. Convergence was
#' confirmed.
fit_quadratic

#' Form predictions from the fitted model
elevxx <- seq(min(willowtit$elev), max(willowtit$elev), length.out=100) #grid for the x axis
predp <- p_pred_quadratic(fit_quadratic$par[1], fit_quadratic$par[2],
                          fit_quadratic$par[3]*1e-06, elevxx)
preds_quad <- data.frame(elev=elevxx, p=predp)

#' Plot the fitted model
ggplot() +
    geom_point(data=freq_table, aes(x=mid, y=p), shape=1, size=2) +
    geom_line(data=preds_quad, aes(x=elev, y=p)) +
    coord_cartesian(ylim=c(0,1)) +
    labs(x="Elevation (m)", 
         y="Probability of occurrence",
         title="Fitted model compared to binned proportions")


#' ### Test of the hump hypothesis
#'
#' A brief preview of model selection. One approach to model selection, arguably
#' the traditional approach, is the frequentist null hypothesis significance
#' test (NHST). An alternative (null) model is that there is no hump, only a
#' monotonically increasing or decreasing probability with elevation. In that
#' case, a suitable model is $logit(p)$ related to elevation by a linear
#' function:
#'
#' $$ln( p/(1-p) ) = \beta_0 + \beta_1 elev$$
#'
#' Note that the backtransformed function
#'
#' $$p = f(b0,b1,elev)$$
#'
#' is still a nonlinear function (sigmoid).
#' 
p_pred_linear  <- function(b0, b1, elev) {
	lp <- b0 + b1 * elev             #logit probability
	prob <- exp(lp) / (1 + exp(lp))  #antilogit
	return(prob)
}

linear_nll <- function(p, occ, elev) {
	ppred <- p_pred_linear(b0=p[1], b1=p[2], elev)
	nll <- -sum(dbinom(occ, size=1, prob=ppred, log=TRUE))
	return(nll)
}
par <- c(-3,0.001) #Starting parameters from direct search
fit_linear <- optim(par, linear_nll, occ=willowtit$y.1, elev=willowtit$elev)
fit_linear #Convergence is good.

#' Form predictions from the fitted model
elevxx <- seq(min(willowtit$elev), max(willowtit$elev), length.out=100) #grid for the x axis
predp <- p_pred_linear(fit_linear$par[1], fit_linear$par[2], elevxx)
preds_lin <- data.frame(elev=elevxx, p=predp)


#' Plot the fitted reduced model (blue) with the data. It's clear that the hump
#' model is a much better description of the data.
ggplot() +
    geom_point(data=freq_table, aes(x=mid, y=p), shape=1, size=2) +
    geom_line(data=preds_quad, aes(x=elev, y=p)) +
    geom_line(data=preds_lin, aes(x=elev, y=p), col="blue") +
    coord_cartesian(ylim=c(0,1)) +
    labs(x="Elevation (m)", 
         y="Probability of occurrence",
         title="Fitted models compared to binned proportions")

#' The NHST is based on the frequentist likelihood ratio test. The deviance (a
#' scaled likelihood ratio) of the null model theoretically has a chi-squared
#' sampling distribution. The test clearly shows the hump is a better model.
nll_H0 <- fit_linear$value
nll_H1 <- fit_quadratic$value
deviance <- 2 * (nll_H0 - nll_H1)
deviance
1 - pchisq(deviance, df=1)  #This is the P-value. Significant at alpha < 0.05.


#' ### Plot predictions as a map
#' ... for the best-fitting (quadratic) model 
predp <- p_pred_quadratic(fit_quadratic$par[1], fit_quadratic$par[2],
                          fit_quadratic$par[3]*1e-06, swissdem$Elev_m)
willowtit_ras <- cbind(swissdem[,1:2],p=predp)

ggplot(willowtit_ras) +
    geom_raster(aes(x=x, y=y, fill=p)) +
    scale_fill_gradientn(colors=heat.colors(14), name="Probability") + 
    coord_quickmap() +
    labs(title="Probability of observing a willow tit in year 1") +
    theme_void() +
    theme(plot.title=element_text(hjust=0.5, vjust=-2))


#' ### Built-in tools for GLMs
#' 
#' Here is the equivalent likelihood analysis using `glm()`. 
glm_quadratic <- glm(y.1 ~ elev + I(elev^2), family=binomial, data=willowtit) 
glm_linear <- glm(y.1 ~ elev, family=binomial, data=willowtit)
#' Likelihood ratio test. Notice that the deviance and p value are the same as
#' the MLE analysis above. The residual deviance is 2X the nll (e.g. compare 2*nll_H1
#' from above).
anova(glm_linear, glm_quadratic, test="Chisq")    
cbind(logLik(glm_linear),logLik(glm_quadratic)) #Log likelihoods, compare to nll_H0 and nll_H1
glm_quadratic  #Residual deviance is 2*nll, compare 2*nll_H1 from above

#' The Bayesian version is
#+ message=FALSE, warning=FALSE
library(rstanarm)
source("source/hpdi.R")
options(mc.cores=parallel::detectCores())
stanfit <- stan_glm(y.1 ~ elev + I(elev^2), family=binomial, data=willowtit)
print(summary(stanfit)[,c("mean","sd","n_eff","Rhat")], digits=3)

#' Credible intervals
newd <- data.frame(elev=seq(min(willowtit$elev),max(willowtit$elev),length.out=100))
#pmu <- posterior_linpred(stanfit, transform=TRUE, newdata=newd)
pmu <- posterior_epred(stanfit, newdata=newd)
mnmu <- colMeans(pmu)
regression_intervals <- t(apply(pmu, 2, hpdi, prob=0.95)) #CPI was no good
colnames(regression_intervals) <- c("mulo95","muhi95")
mcpreds_df <- cbind(newd,mnmu,regression_intervals)

ggplot() +
    geom_point(data=freq_table, aes(x=mid, y=p), shape=1, size=2) +
    geom_ribbon(data=mcpreds_df, aes(x=elev, ymin=mulo95, ymax=muhi95),
        alpha=0.2) +
    geom_line(data=mcpreds_df, aes(x=elev, y=mnmu), col="blue") +
    coord_cartesian(ylim=c(0,1)) +
    labs(x="Elevation (m)", 
         y="Probability of occurrence",
         title="Fitted model with 95% credible intervals compared to binned proportions")

#' The Bayesian model has a more gentle estimate for the quadratic parameter.
