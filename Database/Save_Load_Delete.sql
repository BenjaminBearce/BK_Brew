/* - Save current snap shot of brewing app - */

/* --This will give you column names if you need them
PRAGMA table_info(Chemistry)
Recipe
Ingredient
Weight_Lbs
Percent_Of_Total*/

--SAVE
INSERT INTO Chemistry VALUES('Template2',4,1,32,27,6,40,5.5,-150,-200,5.5,0,0,0,0,0,0);
INSERT INTO Fermentables VALUES('Template2','None',0.0,0);
INSERT INTO Fermentation VALUES('Template2',0);
INSERT INTO Yeast VALUES('Template','None',0,0,100000000000,150000000000,0.5);
INSERT INTO Hops VALUES ('Template2','None',0,0,0,0,0);
INSERT INTO Mash VALUES('Template2',70,165,150,60,0,1.25,0);
INSERT INTO System VALUES('Template2',5,0,0,4,73.5,0,0.25,0,0);

--LOAD
SELECT * FROM Chemistry
SELECT * FROM Fermentables
SELECT * FROM Fermentation
SELECT * FROM Yeast
SELECT * FROM Hops
SELECT * FROM Mash
SELECT * FROM System

--DELETE
DELETE FROM Chemistry WHERE Recipe = 'Test';
DELETE FROM Fermentables WHERE Recipe = 'Test';
DELETE FROM Fermentation WHERE Recipe = 'Test';
DELETE FROM Yeast WHERE Recipe = 'Test';
DELETE FROM Hops WHERE Recipe = 'Test';
DELETE FROM Mash WHERE Recipe = 'Test';
DELETE FROM System WHERE Recipe = 'Test';
