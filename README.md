# sss-2020-group-8 - Data Jockeys
Repository for Group # 8 for SAS Student Symposium 2020 work.

<img src="https://github.com/osu-msba/sss-2020-group-8/blob/master/miscellaneous-resources/group-images/title.PNG" data-canonical-src="https://github.com/osu-msba/sss-2020-group-8/blob/master/miscellaneous-resources/group-images/title.PNG" width="1000" height="500" />

![Group 8](https://github.com/osu-msba/sss-2020-group-8/blob/master/miscellaneous-resources/group-images/group-pic-2.png)

## Important Resources

### Report
PDF: https://github.com/osu-msba/sss-2020-group-8/blob/master/abstract/SASGF2020-group8-data-jockeys.pdf

Word: https://github.com/osu-msba/sss-2020-group-8/blob/master/abstract/SASGF2020-group8-data-jockeys.docx

### Presentation
https://github.com/osu-msba/sss-2020-group-8/blob/master/presentation/suicide_squad.pptx

## 1. Abstract
Suicide is the 2nd leading cause of death in youth aged 12-19. Estimates from the data indicate that nearly 7.4% of the American youth attempted suicide in 2017 alone, while 17.2% of teens considered attempting suicide. The last decade has seen an increase in the number of suicide attempts in teenagers. Given the seriousness of this issue, it is important to identify the factors that are leading to this increase in suicide attempts. This paper closely examines the 2017 Youth Risk Behavior Survey (YRBS), in order to understand characteristics of teenagers who attempted suicide. Latent Class Analysis using SAS® Enterprise Guide® found that among teens who attempted suicide, three distinct classes were evident which were characterized mainly by sexual assault, bullying, and depression respectively. Moreover, using PROC SURVEYLOGISTIC, it was seen that the odds of attempting suicide were four times higher for teens who were sexually assaulted and three times higher for teens who were bullied or abused drugs. Furthermore, it was seen that teenagers who were sexually assaulted had a high co-occurrence of other risky behaviors, and ultimately a higher percentage of multiple suicide attempts. The outcome of the paper highlights the importance of early intervention in preventing teenagers from slipping down a “rabbit hole” of risky behaviors that ultimately lead them to take their own lives. 

## 2. Data

Data used in this analysis was provided by the Center for Disease Control (CDC) and Prevention and gathered using the Youth Risk Behavior Survey (YRBS) [2]. The YRBS essentially was developed to monitor health behaviors that contribute markedly to the leading causes of death, disability, and social problems among youth and adults in the United States. The YRBS includes national, state, territorial, tribal government, and local school-based surveys of representative samples of 9th through 12th grade students. The team used the consolidated national dataset which contains data from YRBS surveys conducted from 1991-2017 biennially nationwide for the United States.
For the 2017 YRBS survey, a total of 192 schools were sampled, of which, 144 schools participated totaling to 18,324 students surveyed.  14,956 of the 18,324 sampled students submitted questionnaires, which composed of 99 questions; 14,765 questionnaires were usable after data editing. The final dataset consists of 14,765 rows and 242 variables, which included original survey variables, calculated variables, and dichotomized variables. 
        
## 3. Problem Statement

This paper attempts to examine co-occurrences of behavioral characteristics among teenagers who attempted suicide and to quantify their impact on suicide attempts using the latest YRBS survey data.

## 4. Analysis

### 1. Trends Analysis
Data:
Individual YRBS national datasets were from 2007-2017 were downloaded from CDC website and frequencies of suicidal ideation variables were computed using proc SURVEYFREQ for each year. Percentages of Variable of interest from each year is taken and consolidated in a single dataset for every unique question. A line plot is plotted to see the trend in the variable in past decade. Even though, it seems increasing, a statistical test need to be conducted to determine if the trends are significant. A linear trend analysis using logistic regression controlling for sex, race and grade has been done. Since time is a discrete variable, it has to be converted to continuous. T3L_L is linear continuous time variable created using proc IML in SAS®. T3Q is Quadratic continuous time variable. A logistic regression model was built using variable of interest as target controlling for sex,race,grade to test the significance in linear trends. If p-value of the continuous time variable is <0.05, then linear trend is significant

Code:
https://github.com/osu-msba/sss-2020-group-8/blob/master/sas-src-code/trend_analysis.sas

### 2. Latent Class Analysis
Data:
https://github.com/osu-msba/sss-2020-group-8/blob/master/data/master-data-files/conssa.sas7bdat

Latent class analysis was done to understand the similar characteristics among teens who attempted suicide. Surveys of only those teens who attempted suicide at least once were used for this analysis. A three latent class model was built using PROC LCA on selected variables which included depression, sexual assault, bullied, and involvement in physical fights. With an aim to explain the behaviors, the model with lower AIC was retained.
It was seen that there was a high probability of depression in all three classes. Moreover, two classes were characterized by a high probability of teens who had been sexually assaulted and bullied respectively. No other distinguishing characteristics were found in the depressed class which indicates unknown causes of depression which may require a more complex analysis or data. In all, 20% of the teens belonged to the sexually assaulted class, and 40% each belonged to both the bullied and depressed classes. 
Furthermore, on profiling, it was seen that the sexually assaulted class had the highest percentage of teens attempting suicide multiple times - more than four times on average.

Code:
https://github.com/osu-msba/sss-2020-group-8/blob/master/sas-src-code/cluster/latent_class_analysis.sas

### 3. Logistic Regression
Data:

From the literature review, 18 variables were selected to understand the relationship with suicidal risk behavior. To understand the causal relationships between the variables, the Bayesian network model was built in SAS® Enterprise MinerTM using High-Performance Bayesian Network Classifier Node. In this model, the Markov Blanket Bayesian network was selected as it helps display significant relationships not only between independent and target variables, but also between independent variables themselves. The significant relationships are shown in the appendix. Seven individual independent variables and four interaction terms were found to be significant among all the 18 independent variables, which were fed into the algorithm. Seven independent variables included drug abuse, sexual minorities, bullied, sexual assault, depression, involvement in physical fights, and perception of obesity. Four interactions were seen between variables: depression and sexual assault, depression and perception of obesity, depression and bullied, drug abuse and sexual assault. 
To quantify the cause-effect relationship of the seven independent variables and the four interaction terms with the target, a logistic regression model was built using survey logistic procedure in order to account for the sampling design. From initial analysis, including all the seven independent and four interactions, it was seen that the most important variable was depression and it was found that a depressed teen is eight times more likely to attempt suicide than a non-depressed teen. Since depression is only a symptom and not a root cause of suicidal ideation, the depression variable was excluded from the analysis [4]. A logistic regression with only six variables and four interaction terms was built. The final odds ratio estimates are shown in Table 5 Odds Ratio Estimates in the appendix. 
The most important variable was seen to be sexual assault, and it was found from our analysis that teens who were sexually assaulted were 4.4 times more likely to attempt suicide than those who were not. The other important variables were bullying, drug consumption, sexual minority, and perception of obesity. Odds of suicide attempts in teens who were bullied at school was 3.2 times more than non-bullied teens. Teens who abuse non-recreational drugs were found to be 2.8 times more likely to attempt suicide than those who did not. Teens who belonged to a sexual minority class (LGBTQ+) are 2.6 times more likely to attempt suicide than teens who did not. Teens who got involved in physical fights were 2.1 times more likely to attempt suicide than those who did not. Teens who felt that they were obese were 1.4 times more likely to attempt suicide than those who did not.


Code:
https://github.com/osu-msba/sss-2020-group-8/blob/master/sas-src-code/survey_logistic_regression.sas
