#-----------------------------------------------------------#
#------------------------ Beer Type ------------------------#
#-----------------------------------------------------------#

beerType <- function(){
        
cat("
--     First we need to choose the beer we want to make!     --
---------------------------------------------------------------\n")

cat("
Which style do you want to focus your attention?
(choose a number...)
     
Choose a number...
    
")

# Display all general styles
Styles$GeneralStyle %>% sort() %>% unique() %>% print()

# Take user selection
selection <- readLines(n = 1)

# Show Selection 
style <- Styles$GeneralStyle %>% sort() %>% unique() %>% .[as.numeric(selection)]

cat("You selected a(n): ", unique(sort(Styles$GeneralStyle))[as.numeric(selection)], "
    
")

cat("Now enter a number for the row of the specific type from that general style:")
temp <- filter(Styles, GeneralStyle == style) %>%
        select(Styles, GravityRange, StyleFinal, BitterRange, SRMRange) %>%
        mutate(Selection = row_number(Styles)) %>%
        arrange(Selection) %>%
        select(Selection
               ,Styles
               ,GravityRange
               ,StyleFinal
               ,BitterRange
               ,SRMRange)
# Show Sub-styles
print(kable(temp))

# Take selection
selection <- readLines(n = 1)

# Show Sub-style Selection
cat("You Chose:")
temp[selection,] %>%
        select(Style = Styles, GravityRange, StyleFinal, BitterRange, SRMRange) %>%
        kable(row.names = FALSE) %>% 
        print()
# Pass selection back to Control Center
return(temp[selection,] %>% select(Style = Styles, GravityRange, StyleFinal, BitterRange, SRMRange))

}



