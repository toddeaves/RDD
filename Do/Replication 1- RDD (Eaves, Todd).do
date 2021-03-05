*Todd R. Eaves*


*Question 1*

https://github.com/scunning1975/causal-inference-class/raw/master/hansen_dwi, clear


*Question 2: The research question asked by Benjamin Hansen was, “What are the effects of blood alcohol content (BAC) thresholds and associated punishment severity have on the commission of future crimes?” Benjamin Hansen uses administrative records on 512,964 DUI stops from the state of Washington (WA) to exploit discrete thresholds that determine both the current as well as potential future punishments for drunk drivers. The Washington DIU data collected spans from 1995 to 2011. He used the data to analyze the causal effect of having a BAC above either the 0.08 or 0.15 threshold on recidivism within four years of the original BAC test. The specific cutoffs for DUI and aggravated DUI allow the usage of a regression discontinuity design. Hansen found evidence concerning the effectiveness of punishments and sanctions in reducing recidivism among drunk drivers, finding evidence that having a BAC above either the 0.08 DUI threshold or the 0.15 aggravated DUI is associated with reduced repeat drunk driving both in the short and long term. The estimates suggest having a BAC over the 0.08 legal limit corresponds with a 2 percent point decline in repeat drunk driving over the next four years. Likewise, having a BAC over the 0.15 enhanced punishment limit is associated with an additional 1 percentage point decline in repeat drunk driving. Importantly, the identification strategy does not estimate the full benefits of the sanctions and punishments, as the presence of more severe punishments may also prevent those who would have otherwise been first-time drunk drivers from ever being tested.*

summarize bac1 male	white acc recidivism

*Question 3*
generate D = 0
replace D = 1 if bac1>=0.08

*Question 4: If people were capable of manipulating their blood alcohol content (bac1), then you would not have a sharp discontinuity. You would end up with a fuzzy regression discontinutiy where you would need to determine if there is sorting of the running variable. To do this you would use the McCrary denisity test. I do not find sorting of the running variable in the histogram which is similar to Hansen's findings.*
histogram bac1, frequency, name(bac1 histogram)

*Question 5: The covariates appear to be balanced at the cutoff, even though my results are not the same as Hansen's*
*the model is recidivism= beta_0 + b_1 D + b_2 bac1 + b_3 D*bac_1
quietly eststo: xi: reg male i.D*bac1
quietly eststo: xi: reg white i.D*bac1
quietly eststo: xi: reg aged i.D*bac1
quietly eststo: xi: reg acc i.D*bac1
esttab, title(Table 2 Panel A)
eststo clear

eststo clear
eststo: quietly regress D male white acc
esttab, ar2

*Question 6: I fould that my graphs look quite similar to Hansen's. After trying various different approaches and techiques I wasn't able to replicate his exact graphs. However, our results are still similar*
cmogram acc bac1, title(Panel A. Accident at scene) lineat(.08) scatter qfitci legend lfitci
cmogram male bac1, title(Panel B. Male) lineat(.08) scatter qfitci legend lfitci
cmogram age bac1, title(Panel C. Age) lineat(.08) scatter qfitci legend lfitci
cmogram white bac1, title(Panel D. White) lineat(.08) scatter qfitci legend lfitci

*Question 7*
generate bac1mod1 = bac1
replace bac1mod1 = 1 if .03<bac1<.13
generate bac1mod2 = bac1
replace bac1mod2 = 1 if .055<bac1<.105
eststo clear
eststo: quietly regress recidivism bac1mod1
eststo: quietly regress recidivism bac1mod2
estimates store m1, title(bac1 linearly)
esttab, ar2
generate BacLinC1 = 0
replace BacLinC1 = (bac1 * bac1mod1)
generate BacLinC2 = 0
replace BacLinC2 = (bac1 * bac1mod2)
eststo: quietly regress recidivism BacLinC1
eststo: quietly regress recidivism BacLinC2
estimates store m2, title(bac1 * cutoff linearly)
esttab, ar2
generate BacLinC3 = 0
replace BacLinC3 = (bac1 * BacLinC1 * BacLinC1^2)
generate BacLinC4 = 0
replace BacLinC4 = (bac1 * BacLinC2 * BacLinC2^2)
eststo: quietly regress recidivism BacLinC3
eststo: quietly regress recidivism BacLinC4
estimates store m3, title(bac1 * cutoff linearly & quatratic)
esttab, ar2

*Question 8*
generate D2 = 0
replace D2 = 1 if bac1<=0.08
cmogram D2 recidivism, title(Linear) lineat(.08) scatter legend lfitci
cmogram D2 recidivism, title(Quadratic) lineat(.08) scatter qfitci legend

*Question 9: I learned a lot about the functionality of STATA. I have never used STATA prior to this class so I face a steep learning curve when it comes to correctly coding.  While I am sure I made a lot of mistakes in this homework assignment, I am sure the exercise will benefit me tremendously in future assignments. I was testing whether there is a statistically significant finding on the causal relationship between recidivism and blood alcohol content (BAC) thresholds and associated punishment severity. I found reduced drunk driving following associated punishment with a previous DUI offense.*
