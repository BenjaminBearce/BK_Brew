#-----------------------------------------------------------#
#-------------------------- Yeast --------------------------#
#-----------------------------------------------------------#

yeast <- function(){
# Choose yeast and calculate if a starter is needed
source("~/Github/BK_Brew/Main_Sections/Yeast/yeastStrainCalculations.R")
yeastInfo <- yeastStrainCalculations()

return(yeastInfo)
}