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
        
        output$waterGraph <- renderPlot({
                GL <- totalGrain()*input$grainAbsorptionFactor
                EL <- input$kettleDeadSpace + input$lauterTunDeadSpace + input$mashTunDeadSpace + input$fermentationTankLoss
                BS <- input$batchSize
                EvL <- BS*((input$boilTime/60)*(input$evap/100)/(1-(input$boilTime/60)*(input$evap/100)))
                TWN <- GL + EL + BS + EvL
                print(GL);print(EL);print(EvL);print(TWN)
                x <- seq(1,180)
                y <- rep(10,180)
                plot(x,y)
        })
        
}