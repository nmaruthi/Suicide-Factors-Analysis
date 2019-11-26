/* ----------------------------------------
Code exported from SAS Enterprise Guide
DATE: Monday, November 25, 2019     TIME: 9:20:26 PM
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

/*   START OF NODE: log_reg_all   */
%LET _CLIENTTASKLABEL='log_reg_all';
%LET _CLIENTPROCESSFLOWNAME='Process Flow';
%LET _CLIENTPROJECTPATH='C:\myStuff\Documents\OSU\osu_notes\3sem\ban\sas-symposium\yrbs\yrbs-eg\yrbs-eg.egp';
%LET _CLIENTPROJECTPATHHOST='DESKTOP-95CLT7D';
%LET _CLIENTPROJECTNAME='yrbs-eg.egp';
%LET _SASPROGRAMFILE='';
%LET _SASPROGRAMFILEHOST='';

*Using QNWORD variables;
proc surveylogistic data = TMP00001.em_save_train;
	model q26 = qn8 qn9 qn10 qn11 qn12 qn13 qn14 qn15 qn16 qn17 qn18 qn19 qn20 qn21 qn22 qn23 qn24 qn25 qn26 qn27 qn28 qn29 qn30 qn31 qn32 qn33 qn34 qn35 qn36 qn37 qn38 qn39 qn40 qn41 qn42 qn43 qn44 qn45 qn46 qn47 qn48 qn49 qn50 qn51 qn52 qn53 qn54 qn55 qn56 qn57 qn58 qn59 qn60 qn61 qn62 qn63 qn64 qn65 qn68 qn69 qn70 qn71 qn72 qn73 qn74 qn75 qn76 qn77 qn78 qn79 qn80 qn81 qn82 qn83 qn84 qn85 qn86 qn87 qn88 qn89 / DF=INFINITY RQSUARE;
	strata stratum ;
	cluster psu ;
	weight weight ;
run;

*Using QNWORD variables;
proc surveylogistic data = TMP00001.em_save_train;
	model q26 = qnobese qnowt qnfrcig qndaycig qnfrevp qndayevp qnfrskl qndayskl qnfrcgr qndaycgr qntb2 
qntb3 qntb4 qniudimp qnshparg qnothhpl qndualbc qnbcnone qnfr0 qnfr1 qnfr2 qnfr3 qnveg0 qnveg1 qnveg2 qnveg3 
qnsoda1 qnsoda2 qnsoda3 qnmilk1 qnmilk2 qnmilk3 qnbk7day qnpa0day qnpa7day qndlype qnnodnt 
qdrivemarijuana qcelldriving qpropertydamage qbullyweight qbullygender qbullygay qchokeself qcigschool 
qchewtobschool qalcoholschool qtypealcohol qhowmarijuana qmarijuanaschool qcurrentcocaine qcurrentheroin 
qcurrentmeth qhallucdrug qprescription30d qgenderexp qtaughtHIV qtaughtsexed qtaughtstd qtaughtcondom qtaughtbc 
qdietpop qcoffeetea qsportsdrink qenergydrink qsugardrink qwater qfastfood qfoodallergy qwenthungry qmusclestrength 
qsunscreenuse qindoortanning qsunburn qconcentrating qcurrentasthma qwheresleep qspeakenglish qtransgender qndrivemarijuana qncelldriving qnpropertydamage qnbullyweight qnbullygender qnbullygay qnchokeself 
qncigschool qnchewtobschool qnalcoholschool qntypealcohol qnhowmarijuana qnmarijuanaschool qncurrentcocaine 
qncurrentheroin qncurrentmeth qnhallucdrug qnprescription30d qngenderexp qntaughtHIV qntaughtsexed qntaughtstd 
qntaughtcondom qntaughtbc qndietpop qncoffeetea qnsportsdrink qnspdrk1 qnspdrk2 qnspdrk3 qnenergydrink qnsugardrink 
qnwater qnwater1 qnwater2 qnwater3 qnfastfood qnfoodallergy qnwenthungry qnmusclestrength qnsunscreenuse 
qnindoortanning qnsunburn qnconcentrating qncurrentasthma qnwheresleep qnspeakenglish qntransgender;
	strata stratum ;
	cluster psu ;
	weight weight ;
run;

proc surveylogistic data = work.yrbs17;
	*model qn28 = qnbullyweight qnbullygender qnbullygay;
	model qn28 = age sex grade race4 race7 qn23 qn24 qnbullygay qnbullyweight/ rsquare;
	strata stratum ;
	cluster psu ;
	weight weight ;
run;

proc print data=work.yrbs17 (obs=100);
run;

* National;
proc surveylogistic data = national.em_save_train;
	model q26 = qn8 qn9 qn10 qn11 qn12 qn13 qn14 qn15 qn16 qn17 qn18 qn19 qn20 qn21 qn22 qn23 qn24 qn25 qn26 qn27 qn28 qn29 qn30 qn31 qn32 qn33 qn34 qn35 qn36 qn37 qn38 qn39 qn40 qn41 qn42 qn43 qn44 qn45 qn46 qn47 qn48 qn49 qn50 qn51 qn52 qn53 qn54 qn55 qn56 qn57 qn58 qn59 qn60 qn61 qn62 qn63 qn64 qn65 qn68 qn69 qn70 qn71 qn72 qn73 qn74 qn75 qn76 qn77 qn78 qn79 qn80 qn81 qn82 qn83 qn84 qn85 qn86 qn87 qn88 qn89 / DF=INFINITY RQSUARE;
	strata stratum ;
	cluster psu ;
	weight weight ;
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
