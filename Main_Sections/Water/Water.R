#-----------------------------------------------------------#
#-------------------------- Water --------------------------#
#-----------------------------------------------------------#

water <- function(){

# Start by choosing a style to get style constants needed to design beer
source("~/Github/BK_Brew/Main_Sections/Water/waterpH.R")
waterpH <- waterpH()

# Create the grain bill 
source("~/Github/BK_Brew/Main_Sections/Water/waterVolumes.R")
waterVolumes <- waterVolumes()
       
waterInfo <- list(waterpH = waterpH, waterVolumes = waterVolumes)
 
return(waterInfo)
}