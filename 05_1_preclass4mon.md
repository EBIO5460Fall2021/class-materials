### Week 5: Preclass preparation for Mon
Make sure you're caught up on any previous work and you've pushed all your work to GitHub! This week is all about **likelihood**, which is a second way of **counting the ways data could have happened**. All reading can be found in the Google Drive (papers are in "Other material as needed", McElreath is in "Texts").

1. **Further reading on P-values (frequentist loose ends)**
   * The ASA statement on P-values is essential reading for any scientist:
   * https://www.tandfonline.com/doi/full/10.1080/00031305.2016.1154108
   * Lew gives a useful perspective on how scientists use and abuse P-values, contrasting Fisher's approach with the null hypothesis significance test (NHST) of Neyman-Pearson:
   * http://doi.wiley.com/10.1111/j.1476-5381.2012.01931.x

2. **Likelihood: counting using the garden of forking paths**
   * Read McElreath Chapter 1, The Golem of Prague, section 1.1 only (pp 1-3)
     * 	McElreath's Golem is our "algorithms"
   * Read McElreath Chapter 2, Small Worlds and Large Worlds, pp 19-24 only
   * Watch McElreath video lecture 1 from 44:00 minutes (ca 15 mins):
   * https://www.youtube.com/watch?v=oy7Ks3YfbDg&list=PLDcUM9US4XdM9_N6XUUFrhghGJ4K25bFc

3. **Watch my lecture on likelihood inference (intro)** 
   * [05_2_slides_likelihood_inference.pdf](05_2_slides_likelihood_inference.pdf)
   * [05_2_video_likelihood_inference.md](05_2_video_likelihood_inference.md) - 18 mins

4. **Problem set on counting the ways**
   * Do the following problems from McElreath Chapter 2:
     * 2E1, 2E2, 2E3
     * 2M4, 2M5, 2M7, 2H1
     * use the counting method, i.e. draw forking paths, for the latter 4 problems
   * Extending from 2H1, on the next birth the panda has twins. What are the likelihoods for the two models: M1 Panda is species A; M2: Panda is species B? Recall that the likelihood is the probability of the data given the model.
   * Now calculate the likelihoods if, instead, the next birth was a singleton
   * To learn effectively, I strongly encourage you to do your own work before searching for the solutions online. I won't be scoring for correct answers.
   * **Push your answers to GitHub.** Can be a scan or photo of hand-written solutions.
  
5. **Likelihood inference algorithm for the linear model**
   * Read the following and explore the R code
   * [05_3_likelihood_inference.md](05_3_likelihood_inference.md)
