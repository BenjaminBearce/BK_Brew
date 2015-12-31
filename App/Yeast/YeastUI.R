# Yeast UI

yeastUI <- function(){
        tabPanel("Yeast",
                 selectInput(inputId = "Yeast",
                             label = "Yeast",
                             choices =  Yeast$YeastStrain),
                 textOutput(outputId = "Yeast")
        )
}