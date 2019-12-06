libname cons 'C:\myStuff\Documents\OSU\osu_notes\3sem\ban\sas-symposium\data\consolidated';

/* Filtering out only 2017 data */
data cons.consSA;
	set cons.sadc_2017_district;
	if year = 2017;
run;

/* Feature engineering variable for narcotics use */
data cons.consSA;
	set cons.consSA;
	if qn57=1 or qnhallucdrug =1 then narcoticdrugs = 1;
	else narcoticdrugs = 2;
run;

/* Filtering out only teens who attempted suicide */
data cons.consSA;
	set cons.consSA;
	if qn28=1;
run;

/* Adding an autoincrement ID field */
DATA cons.CONSSA; SET cons.CONSSA; DO ID = 1, _N_; END; OUTPUT; RUN;

/* Main LCA code */
PROC LCA DATA=cons.CONSSA outpost=cons.res;
	NCLASS 3;
	id ID;
	ITEMS qn19 qn25 qn23 qn17;
	CATEGORIES 2 2 2 2;
	maxiter 999999;
	SEED 861551;
RUN;

/* For profiling classes */
proc sql;
	select best,count(*) from cons.res group by best;
quit;

proc sql;
	create table cons.finalDS as select c.*,r.best from cons.conssa c inner join cons.res r on c.id=r.id;
quit;

/* Looking at frequency of suicide attempts per class*/
data cons.temp;
	length sacount $25.;
	set cons.finalDS;
	cluster=put(best, $1.);
	if q28 =2 then sacount="Once";
	else if q28=3 then sacount="Two or Three";
	else sacount="Four or more";
run;

data cons.temp2;
	length sacount $25.;
	set cons.finalDS;
	cluster=put(best, $1.);
	if q28 =2 then sacount="Once";
	else sacount="Two or more";
run;

proc freq data=cons.temp;
	tables cluster*sacount;
run;

proc freq data=cons.temp2;
	tables cluster*sacount;
run;