### Week 2: Preclass preparation for Wednesday

1. **Reading on design matrix for linear models**. The design matrix is part of the model algorithm that is used for linear models in R and most other statistical programs. The design matrix is part of some simple linear algebra that encodes a system of equations. One of the clearest explanations of design matrices I have seen is given in Kery (2010) *Introduction to WinBUGS for ecologists.* Ch 6. I have posted this to [Google Drive](https://drive.google.com/drive/folders/1ZMEFNuh36pyWLbFx9YBeMjLZCp7orylo?usp=sharing) in the folder "Other material as needed". 
   * Read sections up to and including 6.3.4.
   * Code the examples up as you read. **Push at least the examples for 6.3.2 and 6.3.3 (t-test and simple linear regression) to GitHub**
   * We will cover the rest of the chapter (6.3.5 onward) later.

A little commentary:
* p 67 pg 1. That you can parameterize a linear model in different ways is a key concept. Different parameterizations pertain to different scientific goals. Knowing how to parameterize linear models in ways other than the defaults in R (or any other software) is key to being able to answer the questions you want to ask.
* p 68 pg 1. You can ignore the mentions of WinBUGS (a software package for fitting Bayesian models), which is the special topic of the book. The material in this chapter is very general.
* p 68 pg 3. Linear predictor, link etc are GLM concepts we will revise and take a deeper dive into in a few weeks time. For now, think of the linear predictor simply as the linear model equation.
* p 69 pg 1. Residual: the deviation of a data point from the model for particular values of the parameters (most commonly the best-fit values).
* p 70 pg 1. The notation e_i ~ Normal(0, sigma^2) can be read "e_i *is distributed as* Normal with mean 0 and variance sigma^2", i.e. e_i has a Normal distribution.
* p 71 pg 3. We will soon compare least-squares to maximum likelihood algorithms.
* p 71 pg 4. Recall that in matrix multiplication each element in the first column of the design matrix is multiplied by the first element of the parameter vector, while each element of the second column is multiplied by the second element of the parameter vector.
* p 72 pg 1. In this context, and throughout the reading, "expected value" is synonymous with "mean".

2. **Watch my short video lecture**: An introduction to training algorithms. In class you will translate the pseudocode for the grid search algorithm to R code and use it on your data. So, you might start pondering how to do that.
   * [02_6_slides_training_algorithm.pdf](02_6_slides_training_algorithm.pdf)
   * [02_6_video_training_algorithm.md](02_6_video_training_algorithm.md) - 17 mins

