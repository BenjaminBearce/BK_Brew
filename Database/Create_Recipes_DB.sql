/* - Create Recipes DB and then run the CREATE TABLE and INSERT INTO
statements to generate the recipes tables - */

--Use this to see all tables in all DBs
SELECT * FROM SQLITE_MASTER

--This will generate a DROP TABLE query for each table in all DBs
select 'drop table ' || name || ';'
from sqlite_master
where type = 'table';

/*
drop table Fermentables;
drop table Yeast;
drop table Hops;
drop table Mash;
drop table Chemistry;
drop table Fermentation;
drop table Home;
drop table System;
*/

CREATE TABLE Fermentables(
Recipe varchar,
Ingredient varchar,
Weight_Lbs real,
Percent_Of_Total real
);
#INSERT INTO Fermentables VALUES('Template','None',0.0,0);


CREATE TABLE Yeast(
Recipe varchar,
Name varchar,
Attenuation real,
ABV real,
Init_Cells real,
Needed_Cells real,
Liters_for_Starter real
);
#INSERT INTO Yeast VALUES('Template','None',0,0,100000000000,150000000000,0.5);

CREATE TABLE Hops(
Recipe varchar,
Name varchar,
Weight_Oz real,
Boil_Time_Min int,
Alpha_Acid_Content real,
Utilization real,
IBU real
);
#INSERT INTO Hops VALUES ('Template','None',0,0,0,0,0);

CREATE TABLE Mash(
Recipe varchar,
Init_Grain_Temp real,
Infusion_Temp real,
Sacc_Rest_Temp real,
Mash_Duration int,
Mash_Volume_Gal real,
Mash_Thickness real,
Mash_Out_Vol real
);
#INSERT INTO Mash VALUES('Template',70,165,150,60,0,1.25,0);

CREATE TABLE Chemistry(
Recipe varchar,
Init_Ca real,
Init_Mg real,
Init_Na real,
Init_Cl real,
Init_SO4 real,
Init_HCO3_CaCO3 real,
Estimated_pH real,
Effective_Alkalinity real,
Residual_Alkalinity real,
ph_UP_Gypsum_CaSO4 real,
ph_UP_Cal_Chl_CaCl2 real,
pH_UP_Epsom_Salt_MgSO4 real,
pH_DOWN_Slaked_Lime_CaOH2 real,
pH_DOWN_Baking_Soda_NaHCO3 real,
pH_DOWN_Chalk_CaCO3 real
);

/*INSERT INTO Chemistry VALUES(
	'Template'
	,4,1,32,27,6,40
	,5.5,-150,-200,0,0,0
	,0,0,0);
*/

CREATE TABLE Fermentation(
Recipe varchar,
Days1 Int,Temp1 Int,
Days2 Int,Temp2 Int,
Days3 Int,Temp3 Int,
Days4 Int,Temp4 Int,
Days5 Int,Temp5 Int
);
#INSERT INTO Fermentation VALUES('Template',5,65,5,65,5,65,5,65,5,65);

CREATE TABLE System(
Recipe varchar,
Batch_Size real,
Boil_Time Int,
Evap_Rate Int,
Shrinkage Int,
Efficiency Int,
Boil_Kettle_Dead_Space_Gal real,
Lauter_Tun_Dead_Space_Gal real,
Mash_Tun_Dead_Space_Gal real,
Fermentation_Tank_Loss_Gal real
);
#INSERT INTO System VALUES('Template',5,0,0,4,73.5,0,0.25,0,0);

