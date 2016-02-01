# Hops UI

hopsUI <- function(){
tabPanel("Hops",
        HTML("<br>"),
        fluidRow(
                column(width = 2,
                       selectInput(inputId = "Hops1",
                                   label = "Hops",
                                   choices =  c(1,2,3))
                ),
                column(width = 2,
                       numericInput(inputId = "Weight1",
                                    label = "Weight (Oz)",
                                    value = 0)
                ),
                column(width = 2,
                       numericInput(inputId = "AAU1",
                                    label = "AAU",
                                    value = 0)
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
                                   choices =  c(1,2,3))
                ),
                column(width = 2,
                       numericInput(inputId = "Weight2",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       numericInput(inputId = "AAU2",
                                    label = NULL,
                                    value = 0)
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
                                   choices =  c(1,2,3))
                ),
                column(width = 2,
                       numericInput(inputId = "Weight3",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       numericInput(inputId = "AAU3",
                                    label = NULL,
                                    value = 0)
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
                                   choices =  c(1,2,3))
                ),
                column(width = 2,
                       numericInput(inputId = "Weight4",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       numericInput(inputId = "AAU4",
                                    label = NULL,
                                    value = 0)
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
                                   choices =  c(1,2,3))
                ),
                column(width = 2,
                       numericInput(inputId = "Weight5",
                                    label = NULL,
                                    value = 0)
                ),
                column(width = 2,
                       numericInput(inputId = "AAU5",
                                    label = NULL,
                                    value = 0)
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
        HTML("<br><br><br><br><br>")

)
}