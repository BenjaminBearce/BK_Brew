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
        
        output$MashH20 <- renderText({
                out1 <- input$MashThick1*10.15
        })
        
        output$MashTemp <- renderText({
                out2 <- input$ProteinRest1 - input$GrainTemp1
        })
}