#-----------------------------------------------------------#
#------------------ Making the BK Database -----------------#
#-----------------------------------------------------------#

#Load data collected from EZ Brew spreadsheet
suppressWarnings(suppressMessages(library(gdata))) #Suppress loading info on Excel reading package
suppressWarnings(suppressMessages(library(sqldf)))

setwd("./Database")
Grains_Info <- read.xls("Brewing_Constants.xlsx",sheet = "Grains", stringsAsFactors = F, perl="C:/Strawberry/perl/bin/perl.exe")
Extracts_Info <- read.xls("Brewing_Constants.xlsx",sheet = "Extracts", stringsAsFactors = F, perl="C:/Strawberry/perl/bin/perl.exe")
Adjuncts_Info <- read.xls("Brewing_Constants.xlsx",sheet = "Adjuncts", stringsAsFactors = F, perl="C:/Strawberry/perl/bin/perl.exe")
Hops_Info   <- read.xls("Brewing_Constants.xlsx",sheet = "Hops", stringsAsFactors = F, perl="C:/Strawberry/perl/bin/perl.exe")
Yeast_Info  <- read.xls("Brewing_Constants.xlsx",sheet = "Yeast", stringsAsFactors = F, perl="C:/Strawberry/perl/bin/perl.exe")
Style_Info  <- read.xls("Brewing_Constants.xlsx",sheet = "Styles", stringsAsFactors = F, perl="C:/Strawberry/perl/bin/perl.exe")
Spices_Info  <- read.xls("Brewing_Constants.xlsx",sheet = "Spices", stringsAsFactors = F, perl="C:/Strawberry/perl/bin/perl.exe")

db <- dbConnect(SQLite(), dbname="Ingredients.sqlite")

#Create Tables
#Grains
dbSendQuery(conn = db,
            "CREATE TABLE Grains
            (Ingredients CHAR,
            Value DOUBLE,
            PPG DOUBLE,
            SRM DOUBLE,
            EZWaterCode INT,
            FlavorProfile TEXT)")
#Extracts
dbSendQuery(conn = db,
            "CREATE TABLE Extracts
            (Ingredients CHAR,
            Value DOUBLE,
            PPG DOUBLE,
            SRM DOUBLE,
            EZWaterCode INT,
            FlavorProfile TEXT)")
#Adjuncts
dbSendQuery(conn = db,
            "CREATE TABLE Adjuncts
            (Ingredients CHAR,
            Value DOUBLE,
            PPG DOUBLE,
            SRM DOUBLE,
            EZWaterCode INT,
            FlavorProfile TEXT)")
#Hops
dbSendQuery(conn = db,
            "CREATE TABLE Hops
            (Hops CHAR,
            Value DOUBLE,
            TypicalAlphaAcidPercent DOUBLE,
            FlavorProfile TEXT,
            PossibleSubstitutions CHAR,
            Origin CHAR,
            Storage CHAR,
            AdditionalInformation_History TEXT)")
#Yeast
dbSendQuery(conn = db,
            "CREATE TABLE Yeast
            (YeastStrain CHAR,
            Value DOUBLE,
            ATT DOUBLE,
            TemperatureRange CHAR,
            Flocculation CHAR,
            AlcoholTolerancePercent DOUBLE,
            FlavorCharacteristics TEXT,
            RecommendedStyles TEXT,
            Brewery CHAR)")
#Styles
dbSendQuery(conn = db,
            "CREATE TABLE Styles
            (GeneralStyle CHAR,
            Styles CHAR,
            GravityRange CHAR,
            StyleFinal CHAR,
            BitterRange CHAR,
            SRMRange CHAR)")


dbListFields(db, "Grains")    # The columns in a table
#Load in *.csv data
dbWriteTable(conn = db, name = "Grains", value = Grains_Info, overwrite = F, append = T)
dbWriteTable(conn = db, name = "Extracts", value = Extracts_Info, overwrite = F, append = T)
dbWriteTable(conn = db, name = "Adjuncts", value = Adjuncts_Info, overwrite = F, append = T)
dbWriteTable(conn = db, name = "Hops", value = Hops_Info, overwrite = F, append = T)
dbWriteTable(conn = db, name = "Spices", value = Spices_Info, overwrite = F, append = T)
dbWriteTable(conn = db, name = "Yeast", value = Yeast_Info, overwrite = F, append = T)
dbWriteTable(conn = db, name = "Styles", value = Style_Info, overwrite = F, append = T)



closeAllConnections()










