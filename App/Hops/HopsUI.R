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
                       wellPanel("To Be Calculated...") #switch to verbatimTextOutput() for reactive values
                ),
                column(width = 2,
                       strong("IBU"),
                       wellPanel("To Be Calculated...") #switch to verbatimTextOutput() for reactive values
                )
        )

)
}