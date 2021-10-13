### Week 9: Preclass preparation for Mon-Wed

Generalized linear models using frequentist, likelihood, and Bayesian approaches. Aim for (1)-(3) for Monday and (4)-(5) for Wednesday.

#### 1. Frequentist/likelihood analysis of ant data using `glm()`

GLMs as implemented in the function `glm()` are an interesting blend of frequentist and likelihood approaches. Maximum likelihood is the training algorithm. However, for the inference algorithm the likelihood ratio is merely a statistic and its sampling distribution (which is chi-squared asymptotically) provides the inference. This is in contrast to pure likelihood inference where the likelihood ratio itself forms the inference. In class we decided an improved model for the ants data would be a GLM with a Poisson distribution and a log link. Recall that our scientific goal was to answer the following questions:

* How different is species richness between habitats?
* How does species richness vary with latitude?
* Is this relationship different between habitats?

To answer these questions, you'll need various estimates from the model with their associated uncertainty. Use the [glm cheatsheet](09_2_glm_cheatsheet.R) for inspiration and refer back to what you did already for frequentist ordinary linear models. Use `ggplot()` to plot the data. **Knit to GitHub markdown format and push to GitHub.**

#### 2. Bayesian analysis of the ant data using `stan_glm()` from rstanarm

This analysis will mimic the frequentist analysis but now using `stan_glm()`. See the [glm cheatsheet](09_2_glm_cheatsheet.R) and refer back to what you learned for Bayesian ordinary linear models in McElreath Ch 4.

* `stan_glm()` has good default priors for the parameters. We don't need to specify them as we have up until now. We'll take a look at those choices in class.
* Focus on estimates of the $\beta$s. Regression intervals (credible intervals and prediction intervals) are somewhat more involved coding wise, so I'll demonstrate these later.
* Compare the estimates of uncertainty in the  $\beta$s with those from the frequentist analysis in question 1.

**Knit to GitHub markdown format and push to GitHub.**

#### 3. Poisson distribution

Read the short section on the Poisson distribution, from Chapter 4 of Ben Bolker's book. This reading is in the [Google Drive](https://drive.google.com/drive/folders/1ZMEFNuh36pyWLbFx9YBeMjLZCp7orylo) under Texts. The section called *Bestiary of distributions* is a handy reference going forward.

#### 4. Skill of the week: Data manipulation with dplyr

As we move into data with more complex structure it helps to have a good tool like the `dplyr` package for quickly and consistently manipulating data. Work through chapter 5 of R for Data Science, including the exercises.

* http://r4ds.had.co.nz/transform.html

#### 5. Reading for multilevel models (Ch 12 Gelman & Hill)

Find it in [Google Drive](https://drive.google.com/drive/folders/1ZMEFNuh36pyWLbFx9YBeMjLZCp7orylo) under Texts. Read sections up to and including 12.4 (pp 251-262). The main concepts are:

* Notation
* Partial pooling (shrinkage) versus no pooling versus complete pooling
* Using `lmer()` from the lme4 package



