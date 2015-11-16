#-----------------------------------------------------------#
#---------------- Official BK Brew Software ----------------#
#-----------------------------------------------------------#

suppressWarnings(suppressMessages(library(RODBC)))
suppressWarnings(suppressMessages(library(sqldf)))
suppressMessages(suppressMessages(library(dplyr)))
suppressMessages(suppressMessages(library(knitr)))
suppressMessages(suppressMessages(library(stringr)))

setwd("~/Github/BK_Brew/Database") #Change directory to Brewing directory

#-------------------- Initialize Data ----------------------#
db <- dbConnect(SQLite(), dbname="Ingredients.sqlite")
Grains <- dbReadTable(db, "Grains")
Extracts <- dbReadTable(db, "Extracts")
Adjuncts <- dbReadTable(db, "Adjuncts")
Hops <- dbReadTable(db, "Hops")
Spices <- dbReadTable(db, "Spices")
Yeast <- dbReadTable(db, "Yeast")
Styles <- dbReadTable(db, "Styles")

db <- dbConnect(SQLite(), dbname="BKBrewHouse.sqlite")
BrewHouseConstants <- dbReadTable(db, "SystemSpecificInformation")
#-----------------------------------------------------------#

#--------------------- Welcome Screen ----------------------#
cat("
--Welcome to the BK Brewery Beer Brewing guide!--
----------------------------------------------------------------
-The point is to help you make beer
and understand the process at the same time.
----------------------------------------------------------------
    ")
#--------------------------------------------------#

# Start by choosing a style to get style constants needed to design beer
source("~/Github/BK_Brew/Main_Sections/BeerType.R") #
beerSelection <- beerType()

# Create the grain bill 
source("~/Github/BK_Brew/Main_Sections/Fermentables/Fermentables.R")
grainBill <- fermentables()

# Determine yeast strain to use
source("~/Github/BK_Brew/Main_Sections/Yeast/Yeast.R")
yeastSelection <- yeast()

# Create desired mash schedule
source("~/Github/BK_Brew/Main_Sections/Mash/Mash.R")
mashSchedule <- mash()

# Determine water volumes
source("~/Github/BK_Brew/Main_Sections/Water/Water.R")
waterDetailss <- water()

# Aroma/ bittering hops calculations and IBUs
source("~/Github/BK_Brew/Main_Sections/Hops/Hops.R")
hopsList <- hops()

# Create Brew Day Schedule Next!









