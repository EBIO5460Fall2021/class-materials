### Week 12: Preclass preparation for Mon-Wed

Independent project: identifying scales of variables, writing the mathematical model, and writing the linear model formula. Skill of the week: LaTex for mathematical equations. I suggest finishing 1-3 before Monday.

#### 1. Finish EDA for your individual project

See last week's homework for instructions. **Push your EDA to GitHub**

#### 2. Scales of variables

We saw in the radon example that a multilevel model is used when it is necessary to model multiple scales of variation. The variables in a multilevel model comprise:

1. **Grouping variables** that collect together units belonging to a group. In the radon example, county is a grouping variable; it collects together houses that belong to a county. Such variables are sometimes called random effects. In the mathematical model, these variables will have a distribution indicated by the `~` symbol.
2. **Predictor variables** that predict the outcome in a unit or group. Such variables are sometimes called fixed effects. In the mathematical model, these variables will be part of a deterministic equation following the `=` symbol.

Grouping variables identify spatial and temporal scales of variation to be modeled (i.e. estimated or accounted for). For each grouping variable, there will be an estimated variance at that scale. Thus, in the radon example, both the variance between counties (*county*) and the variance between houses within counties (*residual*) is modeled. This is an example of **spatial scale** but the idea applies to **temporal scales** too. For example, you could have sample weeks within sample seasons; *season* would be a grouping variable that collects together weeks. Spatial and temporal scales could also be mixed to give **spatio-temporal** scales. For example, consider collecting data from multiple sites over multiple years. Then, *site* would be a grouping variable that collected together sample years within the same site and we would then have two scales of variation to be estimated: between sites (pure spatial variance) and between years within sites (spatio-temporal variance). There would also be pure temporal variance, which would be measured by grouping the data by *year* across sites. We could include both *site* and *year* as grouping variables in the same model, depending on our goals.

Predictor variables can apply to different scales. In the radon example, we included both a between-house predictor (*floor*) and a between-county predictor (*uranium*). The between-house predictor was measured for each house, while the between-county predictor was measured for each county (but not each house). Thus, the predictors had a characteristic **scale of measurement**.

For your independent project

1. Identify the scales of variation in the sampling design. What grouping variables are needed?
2. Identify the scale of the response variable: this will be the smallest scale of sampling unit that you can estimate.
3. Identify the scales of measurement for the predictor variables.

Make a sketch of your sample design, like the one we made in class for the radon data, showing the different grouping scales and predictor scales. Take a photo of the sketch, or make it in presentation software, and **push to GitHub**.

#### 3. Skill of the week: LaTeX for mathematical equations

* Tutorial: [repsci05_markdown_equations.md](skills_tutorials/repsci05_markdown_equations.md)

#### 4. Writing the mathematical model and linear model formula

1. Write down the statistical model for the data structure of your independent project using mathematical notation. I typically start with pencil and paper.
   * Write down two parameterizations of the model: the multilevel parameterization and the alternative parameterization, as we covered in class.
   * Review Gelman & Hill Ch 12.5 (Five ways to write the same model).
2. Translate the equations to LaTeX in a markdown `.md` document (generated from `.R` or `.Rmd`).
3. Include parameter and variable definitions and notes about your model with your equations.
4. **Push your markdown to GitHub**

Don't be concerned if you feel uncertain about this. This is a first draft of the model! I have almost never written down the best model the first time and we have continually iterated models for some designs (e.g. the Wog Wog experiment) over many years. Tips:

* The data scale might not be Normal (e.g. might be Poisson or binomial)
* The grouping scales will always be Normal for GLMMs by definition
* If you have multiple scales of nesting, it's not too hard - just think about how it should work - it is quite logical

#### 5. Linear model formula

Write down the corresponding linear model formula for `stan_lmer()`/`stan_glmer()`, or if you have a more complicated project, whatever is appropriate. Add this to the above markdown document and **push to GitHub**.

