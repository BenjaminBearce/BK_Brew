#-----------------------------------------------------------#
#---------------------- Grain Weights ----------------------#
#-----------------------------------------------------------#

fermentablesWeights <- function(grains = FALSE){
if(grains == FALSE){
        cat("No beer selected")
}else{
        
        OG <- beerSelection$GravityRange %>%
              str_split("-") %>%
              unlist() %>%
              as.numeric()
        
        lowerRange <- (OG[1]-1)*1000
        higherRange <- OG[2]
        
        OG <- mean(c(lowerRange,higherRange))/1000+1
        
        totalGravity <- OG*5.5 #OG*Gal
        
        grains <- grains %>% 
                  mutate(IngredientGravity = Percentage*totalGravity) %>%
                  mutate(lbsNeeded = IngredientGravity/(((PPG-1)*1000)*BrewHouseConstants$BrewHouseEfficiency_Percent/100))
                  
        return(grains)   
}
}





