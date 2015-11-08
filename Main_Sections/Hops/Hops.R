#-----------------------------------------------------------#
#-------------------------- Hops ---------------------------#
#-----------------------------------------------------------#

hops <- function(){
# Start by figuring out what aroma and flavoring hops you want and how much
source("~/Github/BK_Brew/Main_Sections/BeerType.R")
aromaFlavorHops <- hopsAromaFlavoring()

# Next subract their IBU from the Styles IBU and figure out how much bitterness
# you need from the bittering hops
source("~/Github/BK_Brew/Main_Sections/Hops/.R")
hops <- hopsBittering(aromaFlavorHops)
}