### Week 15

This week is dedicated to your individual project, including one final topic that you'll apply: fake data simulation and its application in Bayesian analysis as a posterior predictive check. Officially the last day for assessable work is Wed 15 Dec (last day of finals), so that will be the day for completing your GitHub portfolio, including your independent project. Push to GitHub no later than 11:59 PM. However, if you need more time, let me know. I can probably accommodate an extension of a couple more days but grades are due very soon after 15 Dec.

#### 1. GitHub portfolio

Anything with "Push to GitHub" in the homework should be in your portfolio.

#### 2. Independent project

See [00_individual_project.md](00_individual_project.md) to be reminded of the guidelines for what should be included, format etc.

#### 3. Fake data simulation

* Reading and code exploration: [15_2_sim_multilevel.md](15_2_sim_multilevel.md).
* TBA lecture video and notes?

#### 4. Posterior predictive check

* TBA

#### 5. Fake data simulation for your data

Generate fake data from the model for your independent project, and fit the model to the fake data to check that you have everything set up correctly. When I say "from the model" here, I mean from *your* model. What model did you fit to your data? You should generate data from that and then fit your model to the fake data to test that the fitted model is able to recover the known parameters of the fake data simulation. This should be included in your submitted materials for your independent project.

#### 6. Posterior predictive check for your data

Conduct a posterior predictive check using `pp_check()` for the model fitted in your independent project. This should be included in your submitted materials for your independent project. Also check the variations of the ppcheck in `shinystan` and comment on those in your independent project report.
