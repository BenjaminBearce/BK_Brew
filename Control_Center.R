#-----------------------------------------------------------#
#---------------- Official BK Brew Software ----------------#
#-----------------------------------------------------------#

suppressWarnings(suppressMessages(library(RODBC)))
suppressWarnings(suppressMessages(library(sqldf)))
suppressMessages(suppressMessages(library(dplyr)))
suppressMessages(suppressMessages(library(knitr)))

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
#-----------------------------------------------------------#

#--------------------- Welcome Screen ----------------------#
cat("--Welcome to the BK Brewery Beer Brewing guide!--
    ----------------------------------------------------------------
    -The point is to help you make beer
    and understand the process at the same time.
    ----------------------------------------------------------------
    ")
#--------------------------------------------------#

# Start by choosing a style to get style constants needed to design beer
source("~/Github/BK_Brew/Main_Sections/BeerType.R")
beerSelection <- beerType()

# Create the grain bill 
source("~/Github/BK_Brew/Main_Sections/Fermentables.R")
grainBill <- fermentables()

# Determine yeast strain to use
source("~/Github/BK_Brew/Main_Sections/Yeast.R")
yeast()

# Create desired mash schedule
source("~/Github/BK_Brew/Main_Sections/Mash.R")
mash()

# Determine water volumes
source("~/Github/BK_Brew/Main_Sections/Water.R")
water()

# pH and chemistry calculations
source("~/Github/BK_Brew/Main_Sections/pH.R")
pHCorrection()

# Aroma/ bittering hops calculations and IBUs
source("~/Github/BK_Brew/Main_Sections/Hops.R")
hops()

# Create Brew Day Schedule!









