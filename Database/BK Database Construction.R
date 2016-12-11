#-----------------------------------------------------------#
#------------------ Making the BK Database -----------------#
#-----------------------------------------------------------#

#Load data collected from EZ Brew spreadsheet
suppressWarnings(suppressMessages(library(gdata))) #Suppress loading info on Excel reading package
suppressWarnings(suppressMessages(library(sqldf)))


Grains_Info <- read.xls("Brewing_Constants.xlsx",sheet = "Grains", stringsAsFactors = F)#, perl="C:/Strawberry/perl/bin/perl.exe")
Extracts_Info <- read.xls("Brewing_Constants.xlsx",sheet = "Extracts", stringsAsFactors = F)#, perl="C:/Strawberry/perl/bin/perl.exe")
Adjuncts_Info <- read.xls("Brewing_Constants.xlsx",sheet = "Adjuncts", stringsAsFactors = F)#, perl="C:/Strawberry/perl/bin/perl.exe")
Hops_Info   <- read.xls("Brewing_Constants.xlsx",sheet = "Hops", stringsAsFactors = F)#, perl="C:/Strawberry/perl/bin/perl.exe")
Yeast_Info  <- read.xls("Brewing_Constants.xlsx",sheet = "Yeast", stringsAsFactors = F)#, perl="C:/Strawberry/perl/bin/perl.exe")
Style_Info  <- read.xls("Brewing_Constants.xlsx",sheet = "Styles", stringsAsFactors = F)#, perl="C:/Strawberry/perl/bin/perl.exe")
Spices_Info  <- read.xls("Brewing_Constants.xlsx",sheet = "Spices", stringsAsFactors = F)#, perl="C:/Strawberry/perl/bin/perl.exe")
SystemSpecific_Info  <- read.xls("Brewing_Constants.xlsx",sheet = "SystemSpecificInformation", stringsAsFactors = F)#, perl="C:/Strawberry/perl/bin/perl.exe")
Gravity_Correction_Info  <- read.xls("Brewing_Constants.xlsx",sheet = "Gravity_Correction_Chart", stringsAsFactors = F)#, perl="C:/Strawberry/perl/bin/perl.exe")

setwd("Brewing_Constants")
Grains_Info <- read.csv(file = "grains.csv",header = T,stringsAsFactors = F)
Extracts_Info <- read.csv(file = "extracts.csv",header = T,stringsAsFactors = F)
Adjuncts_Info <- read.csv(file = "adjuncts.csv",header = T,stringsAsFactors = F)
Hops_Info   <- read.csv(file = "hops.csv",header = T,stringsAsFactors = F)
Yeast_Info  <- read.csv(file = "yeast.csv",header = T,stringsAsFactors = F)
Style_Info  <- read.csv(file = "styles.csv",header = T,stringsAsFactors = F)
Spices_Info  <- read.csv(file = "spices.csv",header = T,stringsAsFactors = F)
SystemSpecific_Info  <- read.csv(file = "systemSpecificInformation.csv",header = T,stringsAsFactors = F)
Gravity_Correction_Info  <- read.csv(file = "gravityCorrectionChart.csv",header = T,stringsAsFactors = F)

setwd("../")
dbIngredients <- dbConnect(SQLite(), dbname="Ingredients.sqlite")

#Load in *.csv data to Ingredients Database
dbWriteTable(conn = dbIngredients, name = "Grains", value = Grains_Info, overwrite = F, append = T)
dbWriteTable(conn = dbIngredients, name = "Extracts", value = Extracts_Info, overwrite = F, append = T)
dbWriteTable(conn = dbIngredients, name = "Adjuncts", value = Adjuncts_Info, overwrite = F, append = T)
dbWriteTable(conn = dbIngredients, name = "Hops", value = Hops_Info, overwrite = F, append = T)
dbWriteTable(conn = dbIngredients, name = "Yeast", value = Yeast_Info, overwrite = F, append = T)
dbWriteTable(conn = dbIngredients, name = "Styles", value = Style_Info, overwrite = F, append = T)
dbWriteTable(conn = dbIngredients, name = "Spices", value = Spices_Info, overwrite = F, append = T)

dbBKBrewHouse <- dbConnect(SQLite(), dbname="BKBrewHouse.sqlite")

#Load in *.csv data to BKBrew House Database
dbWriteTable(conn = dbBKBrewHouse, name = "SystemSpecificInformation", value = SystemSpecific_Info, overwrite = F, append = T)
dbWriteTable(conn = dbBKBrewHouse, name = "GravityCorrectionChart", value = Gravity_Correction_Info, overwrite = F, append = T)


closeAllConnections()






# #Create Tables...Deprecated...functions above do a great job
# #Grains
# dbSendQuery(conn = dbIngredients,
#             "CREATE TABLE Grains
#             (Ingredients CHAR,
#             Value DOUBLE,
#             PPG DOUBLE,
#             SRM DOUBLE,
#             EZWaterCode INT,
#             FlavorProfile TEXT,
#             DP INT,
#             isGrain INT)")
# #Extracts
# dbSendQuery(conn = dbIngredients,
#             "CREATE TABLE Extracts
#             (Ingredients CHAR,
#             Value DOUBLE,
#             PPG DOUBLE,
#             SRM DOUBLE,
#             EZWaterCode INT,
#             FlavorProfile TEXT,
#             DP INT,
#             isGrain INT)")
# #Adjuncts
# dbSendQuery(conn = dbIngredients,
#             "CREATE TABLE Adjuncts
#             (Ingredients CHAR,
#             Value DOUBLE,
#             PPG DOUBLE,
#             SRM DOUBLE,
#             EZWaterCode INT,
#             FlavorProfile TEXT,
#             DP INT,
#             isGrain INT)")
# #Hops
# dbSendQuery(conn = dbIngredients,
#             "CREATE TABLE Hops
#             (Hops CHAR,
#             Value DOUBLE,
#             TypicalAlphaAcidPercent DOUBLE,
#             FlavorProfile TEXT,
#             PossibleSubstitutions CHAR,
#             Origin CHAR,
#             Storage CHAR,
#             AdditionalInformation_History TEXT)")
# #Yeast
# dbSendQuery(conn = dbIngredients,
#             "CREATE TABLE Yeast
#             (YeastStrain CHAR,
#             Value DOUBLE,
#             ATT DOUBLE,
#             TemperatureRange CHAR,
#             Flocculation CHAR,
#             AlcoholTolerancePercent DOUBLE,
#             FlavorCharacteristics TEXT,
#             RecommendedStyles TEXT,
#             Brewery CHAR)")
# #Styles
# dbSendQuery(conn = dbIngredients,
#             "CREATE TABLE Styles
#             (GeneralStyle CHAR,
#             Styles CHAR,
#             GravityRange CHAR,
#             StyleFinal CHAR,
#             BitterRange CHAR,
#             SRMRange CHAR)")
# #Spices
# dbSendQuery(conn = dbIngredients,
#             "CREATE TABLE Spices
#             (Spice CHAR,
#             Value INT,
#             FlavorProfile TEXT)")
# 
# dbBKBrewHouse <- dbConnect(SQLite(), dbname="BKBrewHouse.sqlite")
# #Create Tables
# #System Specific Information
# dbSendQuery(conn = dbBKBrewHouse,
#             "CREATE TABLE SystemSpecificInformation
#             (BatchSize_Gal DOUBLE,
#             EvapRate_Percent_per_hr DOUBLE,
#             ShrinkageFromCooling_Percent DOUBLE,
#             BrewHouseEfficiency_Percent DOUBLE,
#             WeightOfMashTun_lb DOUBLE,
#             ThermalMassOfMAshTun_btu_per_lb_DegreeF DOUBLE,
#             BoilKettleDeadSpace_Gal DOUBLE,
#             LauterTunDeadSpace_Gal DOUBLE)")
# #Gravity Correction Chart
# dbSendQuery(conn = dbBKBrewHouse,
#             "CREATE TABLE GravityCorrectionChart
#             (Temperature_F INT,
#             Temperature_C INT,
#             Add_SG DOUBLE)")
# 
# 
# #dbListFields(db, "Grains")    # The columns in a table; for a refernece if you need it later
# 
# 
# 
# 
# 







