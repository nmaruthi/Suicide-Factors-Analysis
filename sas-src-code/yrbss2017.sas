
libname yrbs 'C:\Users\ashle\Downloads\YRBSS National 2017';
proc means data = yrbs.yrbs2017;
run;

proc freq data = yrbs.yrbs2017;
run;

proc surveyfreq data = yrbs.yrbs2017;
strata stratum;
weight weight;
run;
data x;
set yrbs.sadc_2017_district;
if year = 2017;
run;


proc surveyfreq data=x ;
strata stratum ;
cluster psu ;
weight weight ;
tables  sex*(qn25 Qn26 Qn27 Qn28 Qn29 Qn30)/ cl ;
run ;


proc surveyfreq data=yrbs.yrbs2017 ;
strata stratum ;
cluster psu ;
weight weight ;
tables  Q2*(qn25 Qn26 Qn27 Qn28 Qn29 Qn30)/ cl ;
run ;

proc surveyfreq data=yrbs.sadc_2017_district ;
strata stratum ;
cluster psu ;
weight weight ;
tables  qn25 Qn26 Qn27 Qn28 Qn29 Qn30/ cl ;
run ;
proc surveyfreq data=yrbs.yrbs2017 ;
tables qn25 qn26 qn27 qn28 qn29 /cl ;
ods output OneWay=f;
strata stratum ;
cluster psu ;
weight weight ;
  
   
run;   



proc print data=f; run;
data yrbs2017_suicide;
set f;
year = 2017;
if f_qn25=1 or f_qn26 = 1 or f_qn27=1 or f_qn28=1 or f_qn29=1;
keep table percent year ;

run;

proc print data=yrbs2017_suicide; run;
proc means data = yrbs.yrbs2017 n min mean max sum;
var weight;
run;

proc freq data=yrbs.yrbs2017 ;
tables q8 qn59 qn51 / cl ;
run ;
