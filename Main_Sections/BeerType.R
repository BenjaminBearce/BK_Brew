#-----------------------------------------------------------#
#------------------------ Beer Type ------------------------#
#-----------------------------------------------------------#

beerType <- function(){
        
cat("
--     First we need to choose the beer we want to make!     --
---------------------------------------------------------------\n\n")

cat("
Which style do you want to focus your attention?
(choose a number...)
     
Choose a number...
    
")

#Display all general styles
print(unique(sort(Styles$GeneralStyle)))

selection <- readLines(n = 1)
style <- unique(sort(Styles$GeneralStyle))[as.numeric(selection)]
cat("You selected a(n): ", unique(sort(Styles$GeneralStyle))[as.numeric(selection)], "
    
")

cat("Now enter a number for the row of the row for the specific type from that general style:")
print(kable(filter(Styles, GeneralStyle == style) %>%
                           select(Styles, GravityRange, StyleFinal, BitterRange, SRMRange)))
selection <- readLines(n = 1)

}



