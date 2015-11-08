#-----------------------------------------------------------#
#----------------------- Fermentables ----------------------#
#-----------------------------------------------------------#

fermentables <- function(){
cat("
--     Now we need to choose the grains we want to create this beer     --
-------------------------------------------------------------------------\n")

cat("You chose: ")
kable(beerSelection, row.names = FALSE) %>% print()
cat("\n")
cat("Look at the grains available and find one you would like")

View(Grains)

cat("Start entering in selections in numerical form and we will review it:
keep entering numbers until you are done, then just press enter...")
# Take user selection
selections <- readLines(n = 10)

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

return(selections)
#...
#You need to take selection and ask for percentages...and then return them
#...
#return(grainBill)
}