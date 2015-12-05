# Sourcing Test

library(shiny)
source("TestFunction.R",local = TRUE)

ui <- fluidPage("Hello World",
                sliderInput(inputId = "slider",label = "Slider Input",min = 1,max = 10,value = 5),
                textOutput(outputId = "testFunction")
                )

server <- function(input, output){
        output$testFunction <- renderText({
                test(input$slider)
        })
}

shinyApp(ui = ui, server = server)