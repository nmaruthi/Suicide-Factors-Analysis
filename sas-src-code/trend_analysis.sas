proc means data = yrbs.sadc_2017_district;
run;

PROC IML; 
X={2007 2009 2011 2013 2015 2017 }; 
XP=ORPOL(X,1); 
PRINT XP; 
RUN; 
QUIT;


PROC IML; 
X={2007 2009 2011 2013 2015 2017 }; 
XP=ORPOL(X,2); 
PRINT XP; 
RUN; 
QUIT;


DATA VARSET; 
SET yrbs.sadc_2017_district; /* Testing for linearity to the left of the joinpoint. */
 IF (YEAR=2007 OR YEAR=2009 OR YEAR=2011 OR YEAR=2013 OR YEAR=2015 OR YEAR=2017);
 IF YEAR=2007 THEN DO ;
 T3L_L=-0.597614;
 T3Q = 0.5455447;
 END;
ELSE IF YEAR=2009 THEN DO;
T3L_L=-0.358569;
T3Q= -0.109109;
END;
ELSE IF YEAR=2011 THEN DO;
T3L_L=-0.119523; 
T3Q = -0.436436;
END;
ELSE IF YEAR=2013 THEN DO;
T3L_L= 0.119523;
T3Q=-0.436436;
END;
ELSE IF YEAR=2015 THEN DO;
T3L_L= 0.3585686; 
T3Q = -0.109109;
END;
ELSE IF YEAR=2017 THEN DO;
T3L_L= 0.5976143; 
T3Q = 0.5455447;
END;
run;

DATA VARSET; 
SET yrbs.sadc_2017_district; /* Testing for linearity to the left of the joinpoint. */
 IF (YEAR=2007 OR YEAR=2009 OR YEAR=2011 OR YEAR=2013 OR YEAR=2015 OR YEAR=2017);
 IF YEAR=2007 THEN 
 T3L_L=-0.597614;
 
ELSE IF YEAR=2009 THEN 
T3L_L=-0.358569;

ELSE IF YEAR=2011 THEN 
T3L_L=-0.119523; 

ELSE IF YEAR=2013 THEN 
T3L_L= 0.119523;

ELSE IF YEAR=2015 THEN 
T3L_L= 0.3585686; 

ELSE IF YEAR=2017 THEN 
T3L_L= 0.5976143; 


run;

/* Table 1: Depressed trend */
proc surveylogistic data = varset;
CLASS SEX RACE4 GRADE YEAR SURVYEAR;
model qn25 = SEX RACE4 GRADE T3L_L;
strata stratum ;
cluster psu ;
weight weight ;
run;

/* Table 2: Considered Suicide */
proc surveylogistic data = varset;
CLASS SEX RACE4 GRADE YEAR SURVYEAR;
model qn26 = SEX RACE4 GRADE T3L_L;
strata stratum ;
cluster psu ;
weight weight ;
run;

/* Table 3: Planned Suicide */
proc surveylogistic data = varset;
CLASS SEX RACE4 GRADE YEAR SURVYEAR;
model qn27 = SEX RACE4 GRADE T3L_L;
strata stratum ;
cluster psu ;
weight weight ;
run;

/* Table 4: Attempted Suicide */
proc surveylogistic data = varset;
CLASS SEX RACE4 GRADE YEAR SURVYEAR;
model qn28 = SEX RACE4 GRADE T3L_L T3Q;
strata stratum ;
cluster psu ;
weight weight ;
run;