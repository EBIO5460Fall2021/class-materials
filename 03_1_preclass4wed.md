### Week 3: Preclass preparation for Wednesday

Give yourself plenty of time for this. Don't leave it until the day before! The week is short but there is plenty to do.

#### 1. Grid search training algorithm

* Finish off coding the algorithm.
* Use the algorithm to train the model with your data (the data you used previously for `lm()`). You should find you get the same answer as `lm()`. If not, something is wrong and you'll need to debug your code.
* Notice and comment on the shape of the sum-of-squares profile (the plot of SSQ vs parameter value). Mentally step through the algorithm, particularly the nested for loops, and confirm that the pattern of points makes sense as an output of the algorithm. Is the algorithm working? Do you understand what it's doing? Make a habit of visualizing the dynamic algorithm in your head (like a movie). This imaginative visualization is a central skill of modeling and science.
* Hint: To see where the optimum is, you'll likely need to adjust the limits of the SSQ axis in the SSQ-profile plots.
* Once you have a working, or semi-working prototype, or you've spent more than 3 hours on it, email me what you have and I'll send you my code for comparison. Then feel free to tweak yours or swap it out with mine.
* **Push your R script to GitHub.**

Writing proper computer code is new to most people in the class. That's OK, it's part of the class to learn some structured programming. It's good to struggle a little ... but not too much! If you get to the point of frustration, just post a question on [slack](https://ebio5460datas-jy81618.slack.com/). Definitely feel free to seek help from your fellow students on slack. It's not cheating, it's collaborative learning! For the more experienced programmers I encourage you to provide help there (but don't just respond with "here's my code"). Alternatively, you can ping me privately on slack or email me if that feels more comfortable than broadcasting everyone.

#### 2. Video lecture: optimization algorithms (especially descent algorithms)
   * [03_2_slides_optim_algos.pdf](03_2_slides_optim_algos.pdf)
   * [03_2_video_optim_algos.md](03_2_video_optim_algos.md) - 12 mins

#### 3. R code for using a descent algorithm

Use the Nelder-Mead algorithm in `optim()` to train your model.

* Modify the example code in [`03_3_train_ssq_optim.R`](03_3_train_ssq_optim.R) for use with your data. 
* **Push your R script to GitHub.**

#### 4. Video lecture: inference algorithms

   * [03_4_slides_inference_algos.pdf](03_4_slides_inference_algos.pdf)
   * [03_4_video_inference_algos.md](03_4_video_inference_algos.md) - 40 mins

There are three parts to the video:
   1. Intro to inference algorithms. **0-9 mins**. Watch this **before the reading**. It includes introducing the big idea of "Considering all the ways that data could have happened".
   2. Frequentist inference: the sampling distribution. **9-29 mins**. Watch this **with the first reading**.
   3. Frequentist inference for `lm()`. **29-40 mins**. Watch this **with the second reading**.

#### 5. Reading: sampling distribution

Read two pieces about the sampling distribution, the foundation of frequentist inference, and how that is applied by `lm()`. These are best read in the markdown `.md` format on GitHub (in the browser) because the equations and so on will render nicely there. The markdown version was generated from the code in the `.Rmd` file. You can explore the code from the `.Rmd` version from within R studio.

   * [03_5_sampling_distribution.md](03_5_sampling_distribution.md)
   * [03_6_lm_ssq_inference.md](03_6_lm_ssq_inference.md)

#### 6. Prediction intervals

* Using `lm()` with your dataset, make and plot prediction intervals for `y|x` (i.e. the interval around the fitted mean line).
* Also plot confidence intervals if you didn't already. 
* **Push your R script to GitHub.**

