# Fermentation UI

fermentationUI <- function(){
        tabPanel("Fermentation",
                 fluidRow(
                   column(width = 4,
                     h4("Fermentation"),
                     column(width = 8,
                            sliderInput(inputId = "fermentationFirstTemp", label = "First Temp", min = 40, max = 80, value = 65),
                            sliderInput(inputId = "fermentationSecondTemp", label = "Second Temp", min = 40, max = 80, value = 65),
                            sliderInput(inputId = "fermentationThirdTemp", label = "Third Temp", min = 40, max = 80, value = 65),
                            sliderInput(inputId = "fermentationFourthTemp", label = "Fourth Temp", min = 40, max = 80, value = 65),
                            sliderInput(inputId = "fermentationFifthTemp", label = "Fifth Temp", min = 40, max = 80, value = 65)
                     ),
                     column(width = 4,
                            numericInput(inputId = "days1",label = "Days",value = 5),HTML("<br>"),HTML("<br>"),
                            numericInput(inputId = "days2",label = "Days",value = 5),HTML("<br>"),HTML("<br>"),
                            numericInput(inputId = "days3",label = "Days",value = 5),HTML("<br>"),HTML("<br>"),
                            numericInput(inputId = "days4",label = "Days",value = 5),HTML("<br>"),HTML("<br>"),
                            numericInput(inputId = "days5",label = "Days",value = 5),HTML("<br>")
                     )
                       
                   ),
                   column(width = 8,
                          plotOutput(outputId = "fermentationPlot")
                   )
                 )
        )
}