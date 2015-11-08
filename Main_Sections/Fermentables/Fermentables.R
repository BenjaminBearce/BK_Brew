#-----------------------------------------------------------#
#----------------------- Fermentables ----------------------#
#-----------------------------------------------------------#

fermentables <- function(){

# First choose grains that you need for this style
source("~/Github/BK_Brew/Main_Sections/Fermantables/fermentablesSelection.R")
beerSelection <- fermentablesSelection()

# Second use selected grains to figure out the weights (lbs) you need
source("~/Github/BK_Brew/Main_Sections/Fermantables/fermentablesWeights.R")
grainBill <- fermentablesWeights(beerSelection)

return(grainBill)
}





