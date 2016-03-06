# Mash UI

mashUI <- function(){
tabPanel("Mash", 
         navlistPanel(widths = c(2,10),
                stepMashUI(),
                singleDecoctionUI(),
                doubleDecoctionUI(),
                enhancedDoubleDecoctionUI(),
                hochkuraDoubleDecoctionUI()
                
#                  tabPanel("Step Mash (using infusions)",
#                           "YEAH YEAH YEAH"
#                  ),
#                  tabPanel("Single Decoction",
#                           "YEAH"
#                  ),
#                  tabPanel("Double Decoction",
#                           "yeah?"
#                  ),
#                  tabPanel("Enhanced Double Decoction",
#                           "yeah!"
#                  ),
#                  tabPanel("Hochkurz Double Decoction",
#                           "yEaH"
#                  )
         )
)
}
