#-----------------------------------------------------------#
#---------------------- Grain Weights ----------------------#
#-----------------------------------------------------------#

fermentablesWeights <- function(beerSelection = FALSE){
if(beerSelection == FALSE){
        cat("No beer selected")
}else{
        OG <- beerSelection$GravityRange %>%
        str_split("-") %>%
        unlist() %>%
        as.numeric()
        
        OG[1] <- (OG[1]-1)*1000
        OG <- mean(OG)
        
        return(FALSE)   
}
}





