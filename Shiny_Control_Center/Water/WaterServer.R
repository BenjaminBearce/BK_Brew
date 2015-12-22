# Water Server

waterServer <- function(input, output){
        output$waterBatchSize <- renderText({
                input$batchSize
        })
        
        output$waterTotalGrain <- renderText({
                totalGrain()
        })
        
        output$waterBoilTime <- renderText({
                input$boilTime
        })
        
        output$waterEquipLoss <- renderText({
                input$kettleDeadSpace + input$lauterTunDeadSpace + input$mashTunDeadSpace + input$fermentationTankLoss
        })
        
}