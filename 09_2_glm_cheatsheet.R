#' --- Frequentist Poisson-log-link GLM cheatsheet
#' for one continuous (x1) + one categorical (x2) variable with 2 levels ("cat1",
#' "cat2")
dat #a dataframe with x1, x2, y
dat$x2 <- factor(dat$x2)
ggplot() +
    geom_point(data=dat,mapping=aes(x=x1,y=y,col=x2))
fit <- glm( y ~ x1 + x2 + x1:x2, family=poisson(link="log"), data=dat )
summary(fit) #Estimates and standard errors, etc
plot(fit,1:6,ask=FALSE) #Diagnostic plots
confint(fit) #confidence intervals for parameters (uses likelihood profiling)
?confint.glm #in package MASS
cov2cor(vcov(fit)) #Correlation matrix for parameters
logLik(fit)  #The log likelihood

#' For GLMs, there is no ' interval = "confidence" ' option in `predict()`, so
#' we have to construct regression intervals from the standard errors. This is
#' approximate. We use 2 * s.e. here. More accurate intervals can be obtained by
#' parametric bootstrap (I'll demonstrate later).
newd <- data.frame(x1 = rep(seq(min(dat$x1), max(dat$x1), length.out=100),2), 
                   x2 = factor(rep(c("cat1","cat2"),each=100)))
preds <- predict(fit,newdata=newd,se.fit=TRUE)
mlp <- preds$fit         #mean of the linear predictor
selp <- preds$se.fit     #se of the linear predictor
cillp <- mlp - 2 * selp  #lower of 95% CI for linear predictor
ciulp <- mlp + 2 * selp  #upper
cilp <- exp(cillp)       #lower of 95% CI for response scale
ciup <- exp(ciulp)       #upper
mp <- exp(mlp)           #mean of response scale

preds <- cbind(newd,preds,cilp,ciup,mp)
preds

#' Base plot
cat <- c("cat1","cat2")
colr <- c("tomato","turquoise")
plot(dat$x1,dat$y,col=colr[dat$x2],pch=20)
for ( i in 1:2 ) {
    subd <- subset(preds,x2==cat[i])
    lines(subd$x1,subd$mp,col=colr[i])
    lines(subd$x1,subd$cilp,col=colr[i],lty=2)
    lines(subd$x1,subd$ciup,col=colr[i],lty=2)
}
#' Try to do the same in ggplot using `geom_line()`, or `geom_ribbon()`.
#' `ggplot()` always needs data frames but different layers can use different
#' data frames, so the trick is to make separate data frames for the data and
#' for the predictions and use those data frames on separate layers of the plot.

#' For prediction intervals, we have to simulate the full fitted model. Again,
#' this is most accurate as a parameteric bootstrap. Later.



#' --- Bayesian Poisson-log-link GLM cheatsheet for rstanarm
library(rstan) #for extract function
library(rstanarm)
theme_set(theme_grey()) #rstanarm overrides default ggplot theme: set it back

fit <- stan_glm( y ~ x1 + x2 + x1:x2, family=poisson(link="log"), data=dat )
#' Default priors are weakly informative

#' The samples themselves
#' You can do anything with these, as explained in McElreath, including
#' everything in the convenience functions below.
samples <- extract(fit$stanfit)
class(samples)
str(samples)
names(samples)
hist(samples$beta[,1]) #e.g. histogram of \beta_1

#' Convenience functions for parameter estimates from the samples
summary(fit,digits=4) #Estimates and standard errors, etc
posterior_interval(fit,prob=0.95) #central posterior intervals, nb default=0.9
vcov(fit,correlation=TRUE) #Correlation matrix
