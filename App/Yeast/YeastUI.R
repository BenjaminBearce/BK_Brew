# Yeast UI

yeastUI <- function(){
        tabPanel("Yeast",
                 fluidRow(
                         column(width = 2,
                                selectInput(inputId = "Yeast",
                                            label = "Yeast",
                                            choices =  Yeast$YeastStrain)
                         ),
                         column(width = 2,
                                uiOutput(outputId = "attenuation")
                         ),
                         column(width = 2,
                                strong("ABV (%)"),
                                verbatimTextOutput(outputId = "ABV") #switch to verbatimTextOutput() for reactive values
                         ),
                         column(width = 2,
                                strong("Style Gravity Range"),
                                verbatimTextOutput(outputId = "FGRange") #switch to verbatimTextOutput() for reactive values
                         ),
                         column(width = 2,
                                uiOutput(outputId = "FG")
                         )
                 ),
                 fluidRow(
                         column(width = 4,
                                strong("How Many Yeast Cells Do you have"),
                                numericInput(inputId = "startYeastCells",
                                            label = "Yeast Cells (Billions)",
                                            value =  100)
                         ),
                         column(width = 2,
                                HTML("<br>"),
                                strong("Needed Cells"),
                                verbatimTextOutput(outputId = "cellsNeeded")
                         )
                 ),
                 fluidRow(
                         column(width = 4,
                                strong("Liters Needed For Starter"),
                                verbatimTextOutput(outputId = "litersNeeded"))
                 )
        )
}