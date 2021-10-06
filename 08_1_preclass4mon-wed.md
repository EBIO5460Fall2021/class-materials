### Week 8: Preclass preparation for Mon-Wed

This week we will cover checking model assumptions (a.k.a diagnostics), introduction to GLM, and visualization theory. Again this is all the homework for the week up front and you can work at your own pace. Get through at least (1-2) by Monday, preferably also (3). We will talk about visualization theory and `ggplot`on Wednesday, so be sure to have read the paper by then.



#### Reminder to submit all homework through week 6

I will give you feedback on your work so far up until the end of week 6 and a grade for completion (1 point per item). Make sure you push all of this to GitHub **by Friday of week 8**. Here is a checklist of the items to be included (i.e. everything marked as "push to GitHub" in homework). Please make it easy for me to find these, preferably by naming your script files by week or organizing them into weekly folders.

- [ ] week 2 initial lm analysis
- [ ] week 2 workflow algorithm
- [ ] week 2 design matrix, 2 problems
- [ ] week 3 grid search algorithm
- [ ] week 3 descent algorithm
- [ ] week 3 lm confidence and prediction intervals
- [ ] week 4 coding style (applied to all code)
- [ ] week 4 empirical bootstrap confidence intervals
- [ ] week 4 bootstrap p-value pseudocode & lm
- [ ] week 5 McElreath C2, 7 problems on counting the ways
- [ ] week 5 likelihood intervals
- [ ] week 6 McElreath C2, 6 problems on using prior information
- [ ] week 6 McElreath C4, 3 problems on Bayesian Normal linear model

If you are behind, do reach out to me so I can help you catch up!



#### 1. Model diagnostics

View and listen to the lectures on model diagnostics (for Normal linear and generalized linear models). The audio is separate; advance the slides manually yourself. This recording is from a previous year. Explore the code.

* Slides: [08_2_diagnostics_slides.pdf](08_2_diagnostics_slides.pdf)
* [Audio (30 mins)](https://www.dropbox.com/s/x3u19ny5yy41t8p/08_aud1_diagnostics.mp3?dl=0)
* Code: [08_3_diagnostics1.R](08_3_diagnostics1.R), [08_4_diagnostics2.R](08_4_diagnostics2.R)

There is a separate R tutorial for QQ plots (there is no accompanying lecture material). 

* tutorial: [08_5_quantiles-qqplots.md](08_5_quantiles-qqplots.md)

An issue that is not covered in these lectures is **leverage**. Currently there are no widespread methods available for this in multilevel models, so it is a bit of a specialist thing for simple linear models and GLMs, so I'm going to skip the theory for it. The general idea is that a point with high leverage is an influential point in a special way: typically it is at one end of the independent variable and it is far from the fitted line relative to other points. Because of the geometry, the point "pulls" on the line like a lever, thus affecting the estimate of the slope. For Normal linear models and some other GLMs leverage can be visualized like this (where `fit` is the saved fitted-model object from `lm()` or `glm()`):
```r
plot(fit,5)
```


#### 2. Diagnostics with naive ants analysis and your linear data

We will continue working with the ants data on Monday, sharing your ideas for analysis. Each group noticed different things and had great ideas for analysis. You also identified features of the data that would make a straight-up linear regression problematic. Here in the homework, we will dive deeper into identifying problems with the assumptions of a standard Normal linear regression model for these data.

* Read in the ants data, check it,  and convert the categorical variables to a factor:

  ```r
  #as.is = TRUE prevents conversion to a factor
  ant <- read.csv("data/ants.csv", as.is = TRUE)
  
  # Check the data
  head(ant)
  class(ant$site) #etc for other variables
  unique(ant$site) #etc
  
  # Set factors manually
  ant$habitat <- factor(ant$habitat)
  ant$site <- factor(ant$site)
  
  # Print the column. The factor levels are shown at the end.
  ant$habitat
  ant$site
  ```

* A  factor is an R data structure for categorical variables. See `?factor`. One attribute of a factor is the *levels* of the factor, sorted alphabetically by default.

* Using a `.R` file (i.e. not `.Rmd`) fit a Normal linear model to the ants data that would best address the scientific questions posed in class. The appropriate model is a multiple regression with an interaction of latitude and habitat. We will not include the `elevation` or `site` variables for now. It's easiest to fit this model with `lm()`. Don't attempt to fix any problems with the model (i.e. don't transform the data or use a different distributional assumption or nonlinear model).

* Describe the patterns in the diagnostic plots. What assumptions of the Normal linear model are violated according to these patterns?

* Do the same for your dataset that you have been using for linear models so far.

* **Knit to a markdown report for each dataset and push to GitHub.**



#### 3. McElreath Ch 9: Introduction to generalized linear models

The models we have encountered so far are a special case of generalized linear models (GLMs). We are going to extend now to the general case of a GLM: a linearly-transformed model with a range of possible distributions for the data. This is within the assumed prerequisite for this class, so hopefully some of this is revision, reinforcement, or another perspective for most of you.

* Read section 9.2, pp 280 - 288.

* Skip 9.2.4. The information here is incorrect: you can indeed compare models with different likelihoods via AIC, although you need to be careful to do it right.

* **Optionally**, the perspective on maximum entropy in section 9.1 is quite interesting and somewhat unique (this perspective is heavily influenced by Jaynes 2003 Probability Theory) but you don't need to understand this. If this is your first time encountering GLMs, skip it since it is more likely to be bewildering than helpful.


#### 4. Skill of the week: Visualization

* Theory and concepts behind `ggplot`. Read Wickham's paper:
* http://vita.had.co.nz/papers/layered-grammar.pdf
* Work through Chapter 3 of R for Data science, including the exercises:
* http://r4ds.had.co.nz/data-visualisation.html
* We will be using `ggplot` a lot from now on.

