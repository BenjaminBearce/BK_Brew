# Hops UI

hopsUI <- function(){
tabPanel("Hops",
         tabPanel("Hops", 
                  selectInput(inputId = "Hops",
                              label = "Hops",
                              choices =  Hops$Hops),
                  textOutput(outputId = "Hops")
         )
)
}