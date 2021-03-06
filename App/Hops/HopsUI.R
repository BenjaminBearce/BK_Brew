# Hops UI

hopsUI <- function(){
tabPanel("Hops",
        HTML("<br>"),
        fluidRow(
                column(width = 2,
                       selectInput(inputId = "Hops1",
                                   label = "Hops",
                                   choices =  Hops$Hops)
                ),
                column(width = 2,
                       numericInput(inputId = "Weight1",
                                    label = "Weight (Oz)",
                                    value = 0)
                ),
                column(width = 2,
                       uiOutput(outputId = "hopsAlphaAcidOne")
                ),
                column(width = 2,
                       numericInput(inputId = "BoilTime1",
                                    label = "Boil Time (min)",
                                    value = 0)
                ),
                column(width = 2,
                       strong("Utilization (%)"),
                       verbatimTextOutput(outputId = "hopsUtilization1") #switch to verbatimTextOutput() for reactive values
                ),
                column(width = 2,
                       strong("IBU"),
                       verbatimTextOutput(outputId = "hopsIBU1") #switch to verbatimTextOutput() for reactive values
                )
        ),
        fluidRow(
                column(width = 2,
                       selectInput(inputId = "Hops2",
                                   label = NULL,
                                   choices =  Hops$Hops)
                ),
                column(width = 2,
                       numericInput(inputId = "Weight2",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       uiOutput(outputId = "hopsAlphaAcidTwo")
                ),
                column(width = 2,
                       numericInput(inputId = "BoilTime2",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       verbatimTextOutput(outputId = "hopsUtilization2") #switch to verbatimTextOutput() for reactive values
                ),
                column(width = 2,
                       verbatimTextOutput(outputId = "hopsIBU2") #switch to verbatimTextOutput() for reactive values
                )
        ),
        fluidRow(
                column(width = 2,
                       selectInput(inputId = "Hops3",
                                   label = NULL,
                                   choices =  Hops$Hops)
                ),
                column(width = 2,
                       numericInput(inputId = "Weight3",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       uiOutput(outputId = "hopsAlphaAcidThree")
                ),
                column(width = 2,
                       numericInput(inputId = "BoilTime3",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       verbatimTextOutput(outputId = "hopsUtilization3") #switch to verbatimTextOutput() for reactive values
                ),
                column(width = 2,
                       verbatimTextOutput(outputId = "hopsIBU3") #switch to verbatimTextOutput() for reactive values
                )
        ),
        fluidRow(
                column(width = 2,
                       selectInput(inputId = "Hops4",
                                   label = NULL,
                                   choices =  Hops$Hops)
                ),
                column(width = 2,
                       numericInput(inputId = "Weight4",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       uiOutput(outputId = "hopsAlphaAcidFour")
                ),
                column(width = 2,
                       numericInput(inputId = "BoilTime4",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       verbatimTextOutput(outputId = "hopsUtilization4") #switch to verbatimTextOutput() for reactive values
                ),
                column(width = 2,
                       verbatimTextOutput(outputId = "hopsIBU4") #switch to verbatimTextOutput() for reactive values
                )
        ),
        fluidRow(
                column(width = 2,
                       selectInput(inputId = "Hops5",
                                   label = NULL,
                                   choices =  Hops$Hops)
                ),
                column(width = 2,
                       numericInput(inputId = "Weight5",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       uiOutput(outputId = "hopsAlphaAcidFive")
                ),
                column(width = 2,
                       numericInput(inputId = "BoilTime5",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       verbatimTextOutput(outputId = "hopsUtilization5") #switch to verbatimTextOutput() for reactive values
                ),
                column(width = 2,
                       verbatimTextOutput(outputId = "hopsIBU5") #switch to verbatimTextOutput() for reactive values
                )
        ),
        fluidRow(
                column(width = 2,
                       strong("Boil Gravity"),
                       verbatimTextOutput(outputId = "hopsBoilGravity")
                )
        ),
        HTML("<br><br><br><br><br>")

)
}