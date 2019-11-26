/* ----------------------------------------
Code exported from SAS Enterprise Guide
DATE: Monday, November 25, 2019     TIME: 9:19:49 PM
PROJECT: yrbs-eg
PROJECT PATH: C:\myStuff\Documents\OSU\osu_notes\3sem\ban\sas-symposium\yrbs\yrbs-eg\yrbs-eg.egp
---------------------------------------- */

/* ---------------------------------- */
/* MACRO: enterpriseguide             */
/* PURPOSE: define a macro variable   */
/*   that contains the file system    */
/*   path of the WORK library on the  */
/*   server.  Note that different     */
/*   logic is needed depending on the */
/*   server type.                     */
/* ---------------------------------- */
%macro enterpriseguide;
%global sasworklocation;
%local tempdsn unique_dsn path;

%if &sysscp=OS %then %do; /* MVS Server */
	%if %sysfunc(getoption(filesystem))=MVS %then %do;
        /* By default, physical file name will be considered a classic MVS data set. */
	    /* Construct dsn that will be unique for each concurrent session under a particular account: */
		filename egtemp '&egtemp' disp=(new,delete); /* create a temporary data set */
 		%let tempdsn=%sysfunc(pathname(egtemp)); /* get dsn */
		filename egtemp clear; /* get rid of data set - we only wanted its name */
		%let unique_dsn=".EGTEMP.%substr(&tempdsn, 1, 16).PDSE"; 
		filename egtmpdir &unique_dsn
			disp=(new,delete,delete) space=(cyl,(5,5,50))
			dsorg=po dsntype=library recfm=vb
			lrecl=8000 blksize=8004 ;
		options fileext=ignore ;
	%end; 
 	%else %do; 
        /* 
		By default, physical file name will be considered an HFS 
		(hierarchical file system) file. 
		*/
		%if "%sysfunc(getoption(filetempdir))"="" %then %do;
			filename egtmpdir '/tmp';
		%end;
		%else %do;
			filename egtmpdir "%sysfunc(getoption(filetempdir))";
		%end;
	%end; 
	%let path=%sysfunc(pathname(egtmpdir));
    %let sasworklocation=%sysfunc(quote(&path));  
%end; /* MVS Server */
%else %do;
	%let sasworklocation = "%sysfunc(getoption(work))/";
%end;
%if &sysscp=VMS_AXP %then %do; /* Alpha VMS server */
	%let sasworklocation = "%sysfunc(getoption(work))";                         
%end;
%if &sysscp=CMS %then %do; 
	%let path = %sysfunc(getoption(work));                         
	%let sasworklocation = "%substr(&path, %index(&path,%str( )))";
%end;
%mend enterpriseguide;

%enterpriseguide


/* Conditionally delete set of tables or views, if they exists          */
/* If the member does not exist, then no action is performed   */
%macro _eg_conditional_dropds /parmbuff;
	
   	%local num;
   	%local stepneeded;
   	%local stepstarted;
   	%local dsname;
	%local name;

   	%let num=1;
	/* flags to determine whether a PROC SQL step is needed */
	/* or even started yet                                  */
	%let stepneeded=0;
	%let stepstarted=0;
   	%let dsname= %qscan(&syspbuff,&num,',()');
	%do %while(&dsname ne);	
		%let name = %sysfunc(left(&dsname));
		%if %qsysfunc(exist(&name)) %then %do;
			%let stepneeded=1;
			%if (&stepstarted eq 0) %then %do;
				proc sql;
				%let stepstarted=1;

			%end;
				drop table &name;
		%end;

		%if %sysfunc(exist(&name,view)) %then %do;
			%let stepneeded=1;
			%if (&stepstarted eq 0) %then %do;
				proc sql;
				%let stepstarted=1;
			%end;
				drop view &name;
		%end;
		%let num=%eval(&num+1);
      	%let dsname=%qscan(&syspbuff,&num,',()');
	%end;
	%if &stepstarted %then %do;
		quit;
	%end;
%mend _eg_conditional_dropds;


/* save the current settings of XPIXELS and YPIXELS */
/* so that they can be restored later               */
%macro _sas_pushchartsize(new_xsize, new_ysize);
	%global _savedxpixels _savedypixels;
	options nonotes;
	proc sql noprint;
	select setting into :_savedxpixels
	from sashelp.vgopt
	where optname eq "XPIXELS";
	select setting into :_savedypixels
	from sashelp.vgopt
	where optname eq "YPIXELS";
	quit;
	options notes;
	GOPTIONS XPIXELS=&new_xsize YPIXELS=&new_ysize;
%mend _sas_pushchartsize;

/* restore the previous values for XPIXELS and YPIXELS */
%macro _sas_popchartsize;
	%if %symexist(_savedxpixels) %then %do;
		GOPTIONS XPIXELS=&_savedxpixels YPIXELS=&_savedypixels;
		%symdel _savedxpixels / nowarn;
		%symdel _savedypixels / nowarn;
	%end;
%mend _sas_popchartsize;


ODS PROCTITLE;
OPTIONS DEV=PNG;
FILENAME EGSRX TEMP;
ODS tagsets.sasreport13(ID=EGSRX) FILE=EGSRX
    STYLE=HTMLBlue
    STYLESHEET=(URL="file:///C:/myStuff/software/sas9.4/SASHome/SASEnterpriseGuide/7.1/Styles/HTMLBlue.css")
    NOGTITLE
    NOGFOOTNOTE
    GPATH=&sasworklocation
    ENCODING=UTF8
    options(rolap="on")
;

/*   START OF NODE: clustering_consolidated_dataset   */
%LET _CLIENTTASKLABEL='clustering_consolidated_dataset';
%LET _CLIENTPROCESSFLOWNAME='Process Flow';
%LET _CLIENTPROJECTPATH='C:\myStuff\Documents\OSU\osu_notes\3sem\ban\sas-symposium\yrbs\yrbs-eg\yrbs-eg.egp';
%LET _CLIENTPROJECTPATHHOST='DESKTOP-95CLT7D';
%LET _CLIENTPROJECTNAME='yrbs-eg.egp';
%LET _SASPROGRAMFILE='';
%LET _SASPROGRAMFILEHOST='';

libname cons 'C:\myStuff\Documents\OSU\osu_notes\3sem\ban\sas-symposium\data\consolidated';

data cons.consSA;
	set cons.sadc_2017_district;
	if year = 2017;
run;

data cons.consSA;
	set cons.consSA;
	if qn57=1 or qnhallucdrug =1 then narcoticdrugs = 1;
	else narcoticdrugs = 2;
run;

data cons.consSA;
	set cons.consSA;
	if qn28=1;
run;

*Check narc for profiling;
PROC LCA DATA=cons.CONSSA;
	TITLE2 ‘Final’;
	NCLASS 3;
	ITEMS qn19 qn25 qn23 qn17 narcoticdrugs;
	CATEGORIES 2 2 2 2 2;
	maxiter 999999;
	SEED 861551;
RUN;

DATA cons.CONSSA; SET cons.CONSSA; DO ID = 1, _N_; END; OUTPUT; RUN;

PROC LCA DATA=cons.CONSSA outpost=cons.res;
	NCLASS 3;
	id ID;
	ITEMS qn19 qn25 qn23 qn17;
	CATEGORIES 2 2 2 2;
	maxiter 999999;
	SEED 861551;
RUN;

proc sql;
	select best,count(*) from cons.res group by best;
quit;

proc sql;
	create table cons.finalDS as select c.*,r.best from cons.conssa c inner join cons.res r on c.id=r.id;
quit;

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

%LET _CLIENTTASKLABEL=;
%LET _CLIENTPROCESSFLOWNAME=;
%LET _CLIENTPROJECTPATH=;
%LET _CLIENTPROJECTPATHHOST=;
%LET _CLIENTPROJECTNAME=;
%LET _SASPROGRAMFILE=;
%LET _SASPROGRAMFILEHOST=;

;*';*";*/;quit;run;
ODS _ALL_ CLOSE;
