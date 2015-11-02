#-----------------------------------------------------------#
#---------------- Official BK Brew Software ----------------#
#-----------------------------------------------------------#

suppressMessages(library(RODBC)) 
suppressMessages(library(sqldf))

setwd("C:/Users/Benjamin/Documents/R/Brewing") #Change directory to Brewing directory

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
source("~/Brewing/BK_Software")
chooseStyle()

# Create the grain bill 
source("~/Brewing/BK_Software")
grainBill()

# Determine how much water you will need
source("~/Brewing/BK_Software")
waterVolumes()

# Choose hops
source("~/Brewing/BK_Software")
hops()

















