# sss-2020-group-8 - Data Jockeys
Repository for Group # 8 for SAS Student Symposium 2020 work.

![Group 8](https://github.com/osu-msba/sss-2020-group-8/blob/master/miscellaneous-resources/group-images/group-pic.PNG)


## 1. Introduction
YRBSS was developed in 1990. YRBSS monitors six types of health-risk behaviors that contribute to the leading causes of death and disability among youth and adults:

  1. Behaviors that contribute to unintentional injuries and violence
  2. Sexual behaviors that contribute to unintended pregnancy and sexually transmitted diseases, including HIV infection
  3. Alcohol and other drug use
  4. Tobacco use
  5. Unhealthy dietary behaviors
  6. Inadequate physical activity

The YRBSS also measures the prevalence of obesity and asthma among youth and young adults. The Oklahoma YRBS is a randomized, statewide survey. Statewide surveys are administered using the established CDC protocol and in partnership with the CDC in the spring of odd-numbered years. 

## 2. Data

  - Description
  
    The complete dataset is broken down into seperate individual files for ease of analysis and to reduce the file size. The complete data is broken down by National, State and District levels. For our analysis, we will be using the state dataset. 
    
    This dataset is further broken down into two parts (a-m, n-z) and contains contains 962,925 observations spread accross 89n variables in all.  The data consists of the original as well as dichotomized versions of the responses. For our analysis, we are presently considering only the original questions. The supplemental questions however, could also be useful in analysis.
    
    Seven kinds of variables are included in the Combined Datasets:
      1. Sample variables (siteCode, siteName, siteType, siteTypeNum, year, survyear, weight, stratum, PSU)
      2. Demographic variables (age, sex, grade, race4, race7)
      3. Body mass index (BMI) variables (stheight, stweight, bmi, bmipct, qnobese, qnowt)
      4. Sexual minority variables
      5. 2017 questionnaire variables
      6. 2017 supplemental variables
      7. Selected additional risk behavior optional question variables

    
  - Creating the dataset
      1. Download the below files:
        ftp://ftp.cdc.gov/pub/data/yrbs/sadc_2017/sadc_2017_state_a_m.dat
        ftp://ftp.cdc.gov/pub/data/yrbs/sadc_2017/sadc_2017_state_n_z.dat
      2. Download and run the below SAS programs to read the ASCII files and create the datasets with formats:
        ftp://ftp.cdc.gov/pub/data/yrbs/sadc_2017/2017_sadc_sas_input_program.sas
        ftp://ftp.cdc.gov/pub/data/yrbs/sadc_2017/2017_sadc_sas_formats_program.sas
  
## 3. Basic Analysis

### i. Suicide/Self-harm trends

![1](https://github.com/osu-msba/sss-2020-group-8/blob/master/miscellaneous-resources/analysis-screenshots/12mo.png)
![2](https://github.com/osu-msba/sss-2020-group-8/blob/master/miscellaneous-resources/analysis-screenshots/12mo_actuallyAttemptSuicide.png)
![3](https://github.com/osu-msba/sss-2020-group-8/blob/master/miscellaneous-resources/analysis-screenshots/12mo_attemptSuicide.png)
![4](https://github.com/osu-msba/sss-2020-group-8/blob/master/miscellaneous-resources/analysis-screenshots/12mo_feltSad.png)
![5](https://github.com/osu-msba/sss-2020-group-8/blob/master/miscellaneous-resources/analysis-screenshots/12mo_injury.png)
