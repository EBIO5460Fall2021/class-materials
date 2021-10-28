### Guidelines for individual projects
This is meant to be a fairly contained and tractable project, not too complex. There should be only one or two analyses (e.g. don't do 20 separate but essentially the same analyses for each species in your dataset, pick one species!). You might need to pick a smaller part of your question or eventual intended analysis.

#### Goal
Option 1) The most likely goal for most of you will be to conduct a complete Bayesian multilevel analysis, from EDA through inference, including all analysis steps (including diagnostics). The final inference(s) should be displayed graphically (e.g. regression curves with credible intervals; differences between treatment means, or whatever is most appropriate depending on your scientific questions), preferably with the data if that makes sense.

Multilevel analysis means that **at least** one variable will determine partial pooling. This should be a grouping variable (e.g. as in "county" or "house" in the radon data).

Option 2) Some other kind of likelihood or Bayesian analysis that extends beyond a standard generalized linear model but is not necessarily multilevel. For example, a nonlinear model, generalized additive model, or something like that. This would be a sophisticated, self learning type of project compared to option 1.

#### Loose rules (more like guidelines or ideals)
The analysis will be a **Bayesian** analysis

You must use:
* `ggplot` for most plotting
* `dplyr` for data manipulation (unless this doesn't make sense)
* `rstanarm` (`stan_glmer()` or `stan_lmer()`) for analysis
* if option 2 above, then you might be adventuring into the land beyond `rstanarm`.

Deviations
* fine to occasionally use `base` graphics as appropriate
* can be helpful and faster to troubleshoot using `glmer()`
* if Bayesian is too expensive for model selection, use `glmer()` with AICc

If you use the above options, the final model should be fit as Bayesian

#### Submit (at least) the following three components:
1. `.R` or `.Rmd` (either is equally acceptable; you should use whatever you prefer in your workflow).
2. Any files required to run your code (data files etc).
3. Report in GitHub markdown format (`.md`, not Rmarkdown) that is rendered from your choice of `.R` or `.Rmd` (this report will include an accompanying folder of figures). Check that this `.md` file displays nicely on the GitHub website.


#### Report
"Report" merely means your analysis with comments but including the four components below. It doesn't mean intro, methods, results etc. Neither is it a formal "results" write up. This would be the code/report that you might make available on GitHub or Figshare or Dryad to accompany your paper. Or it might be for your future self. It's probably neater if you split the script/report into two: one for EDA and one for the formal analysis.

What should the report include?
1. Exploratory Data Analysis (EDA)
2. Sketch/diagram of the data structure
3. The mathematical model. Should be written in latex and displayed as equations in GitHub markdown. 
4. Research the default priors for your model in the `rstanarm` documentation. Give the exact parameter values for the priors (e.g. $\sigma$ = 2.5). Justify these choices or any deviations from the defaults.
5. Analysis: see below.
6. Conclusions: a few sentences summarizing what you found and how it relates to the scientific questions.


#### Analysis
What should the analysis include?

1. Fake data simulation to check your setup
2. Model fits
3. Model checks
  * Has the algorithm converged? (e.g. check MCMC chains, R_hat, n_eff)
  * Visualize the model with the data. Does the fitted model represent the data?
  * Conduct posterior predictive checks (Bayesian) or diagnostic checks (Frequentist)
  * Are assumptions met? (e.g. Normality, symmetry, constant variance)
  * Are there any exceptional cases? (e.g. outliers, influence, leverage)
  * Does everything make sense? (e.g. parameter estimates)
4. Model inferences for parameters or predictions that answer the scientific question, preferably presented graphically. These could include:
  * Posterior distributions
  * Point estimates (points, curves, or surfaces) with uncertainty intervals
  * Hypothesis tests
5. Combine statistical inference with scientific reasoning to form conclusions

#### Data
Include the data so I can run your code. Our GitHub space is completely private and there is no way that your data can be seen by anyone but you and me, so feel free to include it in your repository. This class space will **never** be made public. If you would rather not post your data, please email it to me.

#### File organization
This is up to you but it would be really helpful if you use a naming scheme that will group your independent project files together (e.g. precede all files with `ip_` for "independent project") so I can easily recognize them in your repo. You will probably only have a handful of files (data, code, markdown report, sketch) and a figures directory but you might have others (e.g. derived data) depending on your project.
