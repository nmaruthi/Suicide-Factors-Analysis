
libname yrbs 'C:\Users\ashle\Downloads\YRBSS National 2017';

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

libname yrbs15 'C:\Users\ashle\Downloads\YRBSS national 2015';

proc surveyfreq data=yrbs15.yrbs2015 ;
tables  qn26 qn27 qn28 qn29 qn30/cl ;
ods output OneWay=f;
strata stratum ;
cluster psu ;
weight weight ;
  
   
run;   


data yrbs2015_suicide;
set f;
year = 2015;
if f_qn26 = 1 or f_qn27=1 or f_qn28=1 or f_qn29=1 or f_qn30 =1;
keep table percent year ;

run;

proc print data=yrbs2015_suicide; run;


libname yrbs13 'C:\Users\ashle\Downloads\YRBSS 2013';

proc surveyfreq data=yrbs13.yrbs2013 ;
tables  qn26 qn27 qn28 qn29 qn30/cl ;
ods output OneWay=f;
strata stratum ;
cluster psu ;
weight weight ;
  
   
run;   


data yrbs2013_suicide;
set f;
year = 2013;
if f_qn26 = 1 or f_qn27=1 or f_qn28=1 or f_qn29=1 or f_qn30 =1;
keep table percent year ;

run;

proc print data=yrbs2013_suicide; run;


libname yrbs11 'C:\Users\ashle\Downloads\YRBS 2011';

proc surveyfreq data=yrbs11.yrbs2011 ;
tables  qn24 qn25 qn26 qn27 qn28/cl ;
ods output OneWay=f;
strata stratum ;
cluster psu ;
weight weight ;
  
   
run;   


data yrbs2011_suicide;
set f;
year = 2011;
if f_qn24=1 or f_qn25=1 or f_qn26 = 1 or f_qn27=1 or f_qn28=1;
keep table percent year ;

run;

proc print data=yrbs2011_suicide; run;



libname yrbs09 'C:\Users\ashle\Downloads\YRBS 2009';

proc surveyfreq data=yrbs09.yrbs2009 ;
tables qn23 qn24 qn25 qn26 qn27/cl ;
ods output OneWay=f;
strata stratum ;
cluster psu ;
weight weight ;
  
   
run;   


data yrbs2009_suicide;
set f;
year = 2009;
if f_qn23=1 or f_qn24=1 or f_qn25=1 or f_qn26 = 1 or f_qn27=1;
keep table percent year ;

run;

proc print data=yrbs2009_suicide; run;


libname yrbs07 'C:\Users\ashle\Downloads\YRBS 2007';

proc surveyfreq data=yrbs07.yrbs2007 ;
tables qn23 qn24 qn25 qn26 qn27/cl ;
ods output OneWay=f;
strata stratum ;
cluster psu ;
weight weight ;
  
   
run;   


data yrbs2007_suicide;
set f;
year = 2007;
if f_qn23=1 or f_qn24=1 or f_qn25=1 or f_qn26 = 1 or f_qn27=1;
keep table percent year ;

run;

proc print data=yrbs2007_suicide; run;

data yrbs_suicide;
set yrbs2007_suicide yrbs2009_suicide yrbs2011_suicide yrbs2013_suicide yrbs2015_suicide yrbs2017_suicide;
run;

proc print data=yrbs_suicide; run;

data yrbs_suicide;
length var $100;
set yrbs_suicide;
if year = 2007 & table = 'Table QN23' then var = 'Felt sad in the past 12 months';
if year = 2009 & table = 'Table QN23' then var = 'Felt sad in the past 12 months';
if year = 2011 & table = 'Table QN24' then var = 'Felt sad in the past 12 months';
if year = 2013 & table = 'Table QN26' then var = 'Felt sad in the past 12 months';
if year = 2015 & table = 'Table QN26' then var = 'Felt sad in the past 12 months';
if year = 2017 & table = 'Table QN25' then var = 'Felt sad in the past 12 months';

if year = 2007 & table = 'Table QN24' then var = 'seriously considered suicide in the past 12 months';
if year = 2009 & table = 'Table QN24' then var = 'seriously considered suicide in the past 12 months';
if year = 2011 & table = 'Table QN25' then var = 'seriously considered suicide in the past 12 months';
if year = 2013 & table = 'Table QN27' then var = 'seriously considered suicide in the past 12 months';
if year = 2015 & table = 'Table QN27' then var = 'seriously considered suicide in the past 12 months';
if year = 2017 & table = 'Table QN26' then var = 'seriously considered suicide in the past 12 months';

if year = 2007 & table = 'Table QN25' then var = 'Made a plan on attempting suicide in the past 12 months';
if year = 2009 & table = 'Table QN25' then var = 'Made a plan on attempting suicide in the past 12 months';
if year = 2011 & table = 'Table QN26' then var = 'Made a plan on attempting suicide in the past 12 months';
if year = 2013 & table = 'Table QN28' then var = 'Made a plan on attempting suicide in the past 12 months';
if year = 2015 & table = 'Table QN28' then var = 'Made a plan on attempting suicide in the past 12 months';
if year = 2017 & table = 'Table QN27' then var = 'Made a plan on attempting suicide in the past 12 months';

if year = 2007 & table = 'Table QN26' then var = 'Actually attempted suicide in the past 12 months';
if year = 2009 & table = 'Table QN26' then var = 'Actually attempted suicide in the past 12 months';
if year = 2011 & table = 'Table QN27' then var = 'Actually attempted suicide in the past 12 months';
if year = 2013 & table = 'Table QN29' then var = 'Actually attempted suicide in the past 12 months';
if year = 2015 & table = 'Table QN29' then var = 'Actually attempted suicidein the past 12 months';
if year = 2017 & table = 'Table QN28' then var = 'Actually attempted suicide in the past 12 months';

if year = 2007 & table = 'Table QN27' then var = 'Injury during suicide attempt in the past 12 months';
if year = 2009 & table = 'Table QN27' then var = 'Injury during suicide attempt in the past 12 months';
if year = 2011 & table = 'Table QN28' then var = 'Injury during suicide attempt in the past 12 months';
if year = 2013 & table = 'Table QN30' then var = 'Injury during suicide attempt in the past 12 months';
if year = 2015 & table = 'Table QN30' then var = 'Injury during suicide attempt in the past 12 months';
if year = 2017 & table = 'Table QN39' then var = 'Injury during suicide attempt in the past 12 months';

run;

data felt_sad;
set yrbs_suicide;
if var = 'Felt sad in the past 12 months';
run;

data considered_suicide;
set yrbs_suicide;
if var = 'seriously considered suicide in the past 12 months';
run;

data planned_suicide;
set yrbs_suicide;
if var = 'Made a plan on attempting suicide in the past 12 months';
run;

data attempted_suicide;
set yrbs_suicide;
if var = 'Actually attempted suicide in the past 12 months';
run;

data injury_suicide;
set yrbs_suicide;
if var = 'Injury during suicide attempt in the past 12 months';
run;

ods listing close;
ods html;
goptions reset=all border htext= 1.4;
symbol1 color=blue interpol=join value = dot;
proc gplot data=felt_sad ;
title  "";
axis1 label=("year" font = verdana color = black )
      order = 2007 to 2017 by 2
      ;

axis2 label=("Percent" color = black );
	  plot percent*year /  haxis=axis1 hminor=0
        vaxis=axis2 vminor=1;
run;
quit;
ods html close;
ods listing;
