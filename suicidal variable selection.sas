libname mouni 'C:\Users\mouni\Desktop\SAS Symposium project\clustering';

*to create a set of questions are a variable;
options symbolgen;
%let separator_s =%str( );

%macro X(start,stop);
		%let str=;
		  %do i = &start %to &stop;
		     %let str = %sysfunc(catx(&separator_s,&str,qn&i));
			 %put &str;
		  %end;
%mend X;

****************************************
*****For unintentional category;
****************************************;
%X(08,25);

*SURVEY LOGISTIC REGRESSION ;
proc surveylogistic data= mouni.yrbs2017;
model q26 = &str;
strata stratum;
weight weight;
run;

*PROC SURVEYFREQ;
proc surveyfreq data=mouni.yrbs2017;
   tables  qn10 qn11 qn13 qn19 qn22 qn23 qn25 ;
   strata  stratum;
   cluster PSU;
   weight  Weight;
run;

****************************************
*****For tobacco use category;
****************************************;
%X(30,39);

*SURVEY LOGISTIC REGRESSION ;
proc surveylogistic data= mouni.yrbs2017;
model q26 = &str;
strata stratum;
weight weight;
run;

*PROC SURVEYFREQ;
proc surveyfreq data=mouni.yrbs2017;
   tables qn33 ;
   strata  stratum;
   cluster PSU;
   weight  Weight;
run;

****************************************
*****For electronic vape category;
****************************************;
%X(34,35);

*SURVEY LOGISTIC REGRESSION ;
proc surveylogistic data= mouni.yrbs2017;
model q26 = &str;
strata stratum;
weight weight;
run;

*PROC SURVEYFREQ;
proc surveyfreq data=mouni.yrbs2017;
   tables qn34 qn35 ;
   strata  stratum;
   cluster PSU;
   weight  Weight;
run;

****************************************
*****For alcohola and drugs category;
****************************************;
%X(40,58);

*SURVEY LOGISTIC REGRESSION ;
proc surveylogistic data= mouni.yrbs2017;
model q26 = &str;
strata stratum;
weight weight;
run;

*PROC SURVEYFREQ;
proc surveyfreq data=mouni.yrbs2017;
   tables qn48 qn50 qn55 qn56 qn58 ;
   strata  stratum;
   cluster PSU;
   weight  Weight;
run;

****************************************
*****For sexual behavior category;
****************************************;
%X(59,65);

*SURVEY LOGISTIC REGRESSION ;
proc surveylogistic data= mouni.yrbs2017;
model q26 = qn59 qn60 qn61 qn62 qn63 qn64 qn65;
strata stratum;
weight weight;
run;
**   ;
*PROC SURVEYFREQ;
proc surveyfreq data=mouni.yrbs2017;
   tables qn60 qn63 qn64 qn65;
   strata  stratum;
   cluster PSU;
   weight  Weight;
run;

****************************************
*****For sexual behavior category;
****************************************;
%X(68,69);

*SURVEY LOGISTIC REGRESSION ;
proc surveylogistic data= mouni.yrbs2017;
model q26 = &str;
strata stratum;
weight weight;
run;
**   ;
*PROC SURVEYFREQ;
proc surveyfreq data=mouni.yrbs2017;
   tables qn68 qn69;
   strata  stratum;
   cluster PSU;
   weight  Weight;
run;

****************************************
*****For sexual behavior category;
****************************************;
%X(70,78);

*SURVEY LOGISTIC REGRESSION ;
proc surveylogistic data= mouni.yrbs2017;
model q26 = &str;
strata stratum;
weight weight;
run;
**   ;
*PROC SURVEYFREQ;
proc surveyfreq data=mouni.yrbs2017;
   tables qn73 qn75 qn77 qn78;
   strata  stratum;
   cluster PSU;
   weight  Weight;
run;

****************************************
*****For physical activity category;
****************************************;
%X(79,84);

*SURVEY LOGISTIC REGRESSION ;
proc surveylogistic data= mouni.yrbs2017;
model q26 = &str;
strata stratum;
weight weight;
run;
**   ;
*PROC SURVEYFREQ;
proc surveyfreq data=mouni.yrbs2017;
   tables qn79 qn81 qn82 qn83 qn84;
   strata  stratum;
   cluster PSU;
   weight  Weight;
run;

****************************************
*****For other category;
****************************************;
%X(85,89);

*SURVEY LOGISTIC REGRESSION ;
proc surveylogistic data= mouni.yrbs2017;
model q26 = &str;
strata stratum;
weight weight;
run;
**   ;
*PROC SURVEYFREQ;
proc surveyfreq data=mouni.yrbs2017;
   tables &str;
   strata  stratum;
   cluster PSU;
   weight  Weight;
run;

proc surveylogistic data= mouni.yrbs2017;
model q26 = qn92 qn93 qn98 qn99;
strata stratum;
weight weight;
run;
**   ;
*PROC SURVEYFREQ;
proc surveyfreq data=mouni.yrbs2017;
   tables qn92 qn98;
   strata  stratum;
   cluster PSU;
   weight  Weight;
run;
