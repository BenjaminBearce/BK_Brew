# Mash Server

mashServer <- function(input, output){
        output$mashType <- renderUI({
                if (input$MashType1 == "Step Mash (using direct heat)") {
                        numericInput(inputId="MashNum2",label="MashNum",value=0.0)
                } else {
                        numericInput(inputId="MashNum1",label="MashNum",value=0.0)
                }
        })
        
        output$mashNum <- renderText({
                if (input$MashType1 == "Step Mash (using direct heat)") {
                        finNum = 2.0*input$MashNum2
                } else {
                        finNum = 5.0*input$MashNum1
                }
        })
}