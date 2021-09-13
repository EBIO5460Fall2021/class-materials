### Week 4: Preclass preparation for Wed

Make sure you're caught up on any previous work and you've pushed all your work to GitHub! Don't hesitate to reach out to me for tips with any areas of the homework so far.

In class on Monday we worked on an algorithm for a bootstrapped p-value.  There were some minor variations among groups but the following is what we came up with.

```
fit null model (beta_0 only)
record beta_0 and sigma_e
fit full model (beta_0 and beta_1)
record the estimated beta_1 (call this beta_1_obs)
repeat very many times
    generate data from the null model
    fit the full model
    record the estimated beta_1 (call this beta_1_boot)
calculate the frequency that the simulated beta_1 is as large or larger than the observed beta_1
```

The only other thing we didn't discuss is precisely what it means for a simulated beta_1 to be "as large or larger than observed". We can interpret this in one of two ways:

1. beta_1_boot >= beta_1_obs. This would give what is called a one-tailed p-value.
2. abs(beta_1_boot) >= abs(beta_1_obs). This would give what is called a two-tailed p-value.

The most common form is (2). The two-tailed p-value is interpreted as the probability of seeing an **effect** as large or larger than the one observed, given the null hypothesis is true. Here, the effect is the slope, and the slope could be (spuriously) large in either the positive direction or the negative direction. It's the magnitude we're concerned with and the sign could go either way unless we have a clear prior justification for the sign of the slope.

We also discussed whether to t-standardize the beta_1 estimates. Go with the unstandardized beta_1 to start with. It's just as "correct". If you want to explore, try also the t-standardized version. This is merely a different scale for the effect but it is the scale used in the classical test.



**Apply this algorithm to your linear dataset**

* Code your algorithm up in R to calculate the p-value for the slope in your dataset.
* It won't be exactly the same but it should be in the same ballpark as the p-value you obtain from `lm()`.

Include the pseudocode in the preamble of your R script. **Push your script to GitHub.**

