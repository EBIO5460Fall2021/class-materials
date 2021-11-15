#' ---
#' title: Binomial GLM. Swiss breeding bird survey example
#' author: Brett Melbourne
#' date: 16 Nov 2020
#' output:
#'     github_document:
#'         pandoc_args: --webtex
#' ---

#' Apologies for lack of ggplot here. I didn't have time to convert this
#' example. It's always good to know base plot too!
#' 

#' Willow tit distribution with altitude. This is an example of a nonlinear
#' biological model with a binomial distribution. The model is logit-linear and
#' together with the binomial distribution, this combination is the special case
#' of logistic regression. The data are occurrence (presence- absence) of the
#' willow tit. This example is from Royle JA & Dorazio RM (2008) Hierarchical
#' Modeling and Inference in Ecology, p 87. Altitude data are from
#' eros.usgs.gov. To exactly replicate the analysis on p 87, first rescale the
#' elevation data: elev <- scale(elev). I don't do that here in order to show
#' another strategy for fixing an algorithm - i.e. rescaling parameters.
#' 

#' Read in and plot elevation data for Switzerland. 
swissmap <- as.matrix(read.csv("data/switzerland.csv",header=FALSE))
swtzrlndElev <- t(swissmap)[,246:1] #Rotate matrix for plotting
#+ fig.width=9.8, fig.height=7
par(mar=c(0.1,0.1,0.1,0.1),oma=c(3,1,3,8))
cols <- c(terrain.colors(22))
brks <- c(seq(100,4500,by=200))
image(swtzrlndElev,col=cols,breaks=brks,axes=FALSE)
box()
mtext("Switzerland - elevation in metres",line=1)
# Add a legend
par(mar=c(0.1,0.1,0.1,3.1),oma=c(3,43,3,1),new=TRUE)
z <- matrix(1,nrow=length(cols),ncol=1)
barplot(z,col=cols,axes=FALSE)
axis(4, at = seq(0,22,2),labels=brks[seq(1,23,2)],lwd=0,lwd.ticks=1,las=1)

#' Read in the bird data
willowtit_data <- read.csv("data/wtmatrix.csv")  #Dataset from Royle & Dorazio
occ <- willowtit_data[,"y.1"]  #The occurrence data
elev <- willowtit_data[,"elev"]
cbind(occ,elev)[1:30,] #Take a look at the first 30 rows of data

#' Plot the data 
plot(elev,occ,xlab="Elevation (m)",ylab="Occurrence",
     main="Willow tits in Switzerland")
occtab <- table(occ,cut(elev,breaks=seq(0,3000,by=500)))
freq <- occtab[2,]/colSums(occtab)

#' ... also summarized by binning into 500 m increments
plot(seq(250,3000,by=500),freq,xlim=c(0,3000),xlab="Elevation (m)",
    ylab="Frequency of occurrence",type="o")
abline(v=seq(0,3000,by=500),col="gray",lty=2)
mtext("Relationship appears humped",line=1)

#' ## Binomial GLM the hard way
#'
#' We'll first do this the hard way by coding the likelihood and optimizing
#' directly. I'm doing this to show the structure of the analysis and the
#' general algorithm. You won't do this for ordinary binomial GLMs like this
#' example because you can use the one-line tool `glm()` that does the same
#' thing and `stan_glm()` for the Bayesian version with sensible priors (see
#' further below).
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
p_pred_quadratic  <- function( b0, b1, b2, elev ) {
    lp <- b0 + b1 * elev + b2 * elev^2   #logit p
    prob <- exp(lp)/(1+exp(lp))          #antilogit
    return(prob)
}

#' ### Negative log likelihood function
#'
#' ... for logit-quadratic model with binomial distribution. A log scale direct
#' search showed that $\beta_2$ is several orders of magnitude smaller than the
#' other parameters. Optimization is better behaved if all parameters are on
#' similar scales. We use a simple trick here, which is to pass nll a parameter
#' on a similar scale to the others but then rescale the parameter in the nll
#' function.
#' 
quadratic_nll <- function(p,occ,elev){
	b2 <- p[3] * 1e-06  #Rescale
    ppred <- p_pred_quadratic(b0=p[1],b1=p[2],b2,elev)
    nll <- -sum(dbinom(occ,size=1,prob=ppred,log=TRUE))
    return(nll)
}

#' I first did a bit of a grid search to get some idea of the likelihood surface
#' and that suggested these starting values for `optim()`.
par <- c(-8,0.02,-3)

#' Now find the MLE using `optim()` with the Nelder-Mead algorithm
fit_quadratic <- optim(par,quadratic_nll,occ=occ,elev=elev)

#' Here are the results of the fit. $\beta_2$ is par[3]*1e-06. Convergence was
#' confirmed.
fit_quadratic

#' Plot the fitted model with the data
plot(elev,occ,xlab="Elevation",ylab="Probability of occurrence")
elevxx <- seq(min(elev),max(elev), length.out=100) #grid for the x axis
predp <- p_pred_quadratic(fit_quadratic$par[1],fit_quadratic$par[2],
                          fit_quadratic$par[3]*1e-06,elevxx)
lines(elevxx,predp)
points(seq(250,3000,by=500),freq,col="red")
legend(2000,0.9,c("Data","Freq, 500m bins"),col=c("black","red"),pch=1)


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
p_pred_linear  <- function( b0, b1, elev ) {
	lp <- b0 + b1 * elev            #logit probability
	prob <- exp(lp)/(1+exp(lp))     #antilogit
	return(prob)
}

linear_nll <- function( p, occ, elev ) {
	ppred <- p_pred_linear(b0=p[1],b1=p[2],elev)
	nll <- -sum(dbinom(occ,size=1,prob=ppred,log=TRUE))
	return(nll)
}
par <- c(-3,0.001) #Starting parameters from direct search
fit_linear <- optim(par,linear_nll,occ=occ,elev=elev)
fit_linear #Convergence is good.

#' Plot the fitted reduced model (blue) with the data. It's clear that the hump
#' model is a much better description of the data.
#' 
plot(elev,occ,xlab="Elevation",ylab="Probability of occurrence")
elevxx <- seq(min(elev),max(elev), length.out=100) #grid for the x axis
lines(elevxx,p_pred_linear(fit_linear$par[1],fit_linear$par[2],
                           elevxx),col="blue")
lines(elevxx,p_pred_quadratic(fit_quadratic$par[1],fit_quadratic$par[2],
                          fit_quadratic$par[3]*1e-06,elevxx))
points(seq(250,3000,by=500),freq,col="red")
legend(2000,0.9,c("Data","Freq, 500m bins"),col=c("black","red"),pch=1)

#' The NHST is based on the frequentist likelihood ratio test. The deviance (a
#' scaled likelihood ratio) of the null model theoretically has a chi-squared
#' sampling distribution. The test clearly shows the hump is a better model.
nll_H0 <- fit_linear$value
nll_H1 <- fit_quadratic$value
deviance <- 2 * ( nll_H0 - nll_H1 )
deviance
1 - pchisq(deviance,df=1)  #This is the P-value. Significant at alpha < 0.05.


#' ### Plot predictions as a map
#' 
#' ... for the best fitting (quadratic) model 
predp <- p_pred_quadratic(fit_quadratic$par[1],fit_quadratic$par[2],
                          fit_quadratic$par[3]*1e-06,swtzrlndElev)
#min(predp) #To get good bounds for the color scale
#max(predp)

#+ fig.width=9.8, fig.height=7
par(mar=c(0.1,0.1,0.1,0.1),oma=c(3,1,3,8))
cols <- c(heat.colors(14))
brks <- c(seq(0,0.7,length.out=15))
image(predp,col=cols,breaks=brks,axes=FALSE)
box()
mtext("Predicted probability of willow tit occurrence",line=1)
# Legend
par(mar=c(0.1,0.1,0.1,3.1),oma=c(3,43,3,1),new=TRUE)
z <- matrix(1,nrow=length(cols),ncol=1)
barplot(z,col=cols,axes=FALSE)
axis(4, at = seq(0,14,2),labels=brks[seq(1,15,2)],lwd=0,lwd.ticks=1,las=1)


#' ### Built-in tools for GLMs
#' 
#' Here is the equivalent likelihood analysis using `glm()`. 
glm_quadratic <- glm(occ ~ elev + I(elev^2), family=binomial) 
glm_linear <- glm(occ ~ elev, family=binomial)
#' Likelihood ratio test. Notice that the deviance and p value are the same as
#' the MLE analysis above. The residual deviance is 2X the nll (e.g. compare 2*nll_H1
#' from above).
anova(glm_linear,glm_quadratic,test="Chisq")    
cbind(logLik(glm_linear),logLik(glm_quadratic)) #Log likelihoods, compare to nll_H0 and nll_H1
glm_quadratic  #Residual deviance is 2*nll, compare 2*nll_H1 from above

#' The Bayesian version is
#+ results=FALSE, message=FALSE, warning=FALSE
library(rstanarm)
options(mc.cores = parallel::detectCores())
stanfit <- stan_glm(occ ~ elev + I(elev^2), family=binomial, data=data.frame(occ,elev))
print(summary(stanfit)[,c("mean","sd","n_eff","Rhat")],digits=3)
