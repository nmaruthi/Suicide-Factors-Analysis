data x;
   set yrbs.sadc_2017_district;
   if year = 2017;
   run;

   data x_drug;
   set x;
   if qn57=1 or qnhallucdrug =1 then narcoticdrugs = 1;
   else narcoticdrugs = 2;
   run;
    
    data x_drug;
    set x_drug;
    if sexid in(2,3,4) then LGBQ = '1';
    else LGBQ = '2';
    run;
    data x_drug;
    set x_drug;
    if qn23 = 1 or qn24 =1 then bully = '1';
    else bully = '2';
    run;

/* Imputing data */
   proc surveyimpute data=x_drug method=hotdeck(selection=WEIGHTED) seed=3242 ndonors=1; 
   Var qn17 qn19 qn89 qn23 qn24 qn25 SEX RACE4 GRADE narcoticdrugs LGBQ bully; 
   Class qn17 qn19 qn89 qn23 qn24 qn25 SEX RACE4 GRADE narcoticdrugs LGBQ bully;
   weight weight; 
   Cluster PSU;
   Strata stratum;
   output out= x_drugImp; 
   run;

/* Table 7: Code for Survey Logistic Results*/
   proc surveylogistic data = x_drugImp;
   CLASS SEX(ref ='Female') RACE4(ref = 'All other races') GRADE(ref = '12th') qn19(ref = '2') qn68(ref = '2') 
   qn23(ref = '2') qn17(ref='2') qn24(ref = '2') narcoticdrugs(ref = '2') LGBQ(ref='2') bully(ref='2');
   model qn28(event ='1') = SEX RACE4 GRADE qn17 qn19 qn68 narcoticdrugs LGBQ bully /rsquare;
   strata stratum ;
   cluster psu ;
   weight weight ;
   run;