#-----------------------------------------------------------#
#--------------------- Grain Selection ---------------------#
#-----------------------------------------------------------#

fermentablesSelection <- function(){
cat("
--     Now we need to choose the grains we want to create this beer     --
-------------------------------------------------------------------------\n")

cat("You chose: ")
kable(beerSelection, row.names = FALSE) %>% print()
cat("\n")
cat("Look at the grains available and find the relevant grains you would like.\n\n")

View(Grains)

cat("Start entering in selections in numerical form and we will review it:
keep entering numbers until you are done, then just press enter...")
# Take user selection
selections <- scan()

# Show Selection 
grains <- Grains$Ingredients %>% sort() %>% unique() %>% .[as.numeric(selections)]

selections <- filter(Grains,Ingredients %in% grains) %>%
              select(Ingredients
                    ,Value
                    ,PPG
                    ,SRM
                    ,EZWaterCode) 


cat("You selected:")
kable(selections, row.names = FALSE) %>% print() 
View(title = "Selection", x = filter(Grains,Ingredients %in% grains))

#Reattach the Flavor Profile Column before returning
selections <- filter(Grains,Ingredients %in% grains)

#Add percentage column
selections <- mutate(selections, Percentage = 0)
cat("Now we need to choose the percentages we want for each grain.\n\n")

TotalPercentage <- 0
while(TotalPercentage != 100){
        for(grain in selections$Ingredients){
                cat(paste("What percentage do you want for:"
                    ,filter(selections, Ingredients == grain) %>% 
                     select(Ingredients)
                    ,"\n"))
                
                percentage <- scan(nmax = 1)
                if(percentage < 0 | percentage > 100){
                        cat("You entered an invalid percentage value,\n make sure percentage entered is > 0 and < 100")
                        break
                }
                selections[which(selections$Ingredients == grain), "Percentage"] <- percentage
                
        }
        
        TotalPercentage <- selections$Percentage %>% sum()
        if(TotalPercentage != 100){
        cat("Your total percentage is not equal to 100%...re-enter your percentages\n\n")
        }
        
}

return(selections)
}





