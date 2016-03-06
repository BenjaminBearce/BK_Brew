# Mash Server

mashServer <- function(input, output){
        output$mashType <- renderUI({
                if(input$mashType == "Step Mash (using infusions)"){
                        numericInput(inputId = "grainTemp1", label = "Grain Temp1", value = 70)
                }else if(input$mashType == "Single Decoction"){
                        numericInput(inputId = "grainTemp2", label = "Grain Temp2", value = 71)
                }
        })
}
