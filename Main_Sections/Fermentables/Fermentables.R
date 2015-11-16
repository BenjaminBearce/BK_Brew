#-----------------------------------------------------------#
#----------------------- Fermentables ----------------------#
#-----------------------------------------------------------#

fermentables <- function(){

# First choose grains that you need for this style
source("~/Github/BK_Brew/Main_Sections/Fermentables/fermentablesSelection.R")
grains <- fermentablesSelection()
browser()
# Second use selected grains to figure out the weights (lbs) you need
source("~/Github/BK_Brew/Main_Sections/Fermentables/fermentablesWeights.R")
grainBill <- fermentablesWeights(grains)

return(grainBill)
}





