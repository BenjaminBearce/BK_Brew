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
                #Grains
                GL <- totalGrain()*input$grainAbsorptionFactor
                #Shrinkage Reduction for equipment losses
                shrinkage <- (1-input$shrink/100)
                #Equipment Losses broken down
                lauterLoss <- input$lauterTunDeadSpace*shrinkage
                mashLoss <- input$mashTunDeadSpace*shrinkage
                kettleLoss <- input$kettleDeadSpace*shrinkage
                fermentationLoss <- input$fermentationTankLoss
                print("GL")
                print(GL)
                print("EL")
                EL <- lauterLoss + mashLoss + kettleLoss + fermentationLoss
                print(EL)
                print("BS")
                BS <- input$batchSize
                print(BS)
                print("EvL")
                EvL <- BS*((input$boilTime/60)*(input$evap/100)/(1-(input$boilTime/60)*(input$evap/100)))
                print(EvL)
                print("TWN")
                TWN <- GL + EL + BS + EvL
                print(TWN)
                
#                 waterData <- data.frame(step = 1:6,
#                                         TWN = ,
#                                         PostMash = ,
#                                         PostSparge = ,
#                                         PostBoil = ,
#                                         Cooling = ,
#                                         Fermentation = )
                
                
                waterData <- data.frame(step = seq(1,6), vol = c(TWN,
                                                                 TWN-GL,
                                                                 TWN-GL-mashLoss,
                                                                 TWN-GL-mashLoss-lauterLoss,
                                                                 TWN-GL-mashLoss-lauterLoss-kettleLoss-EvL,
                                                                 TWN-GL-mashLoss-lauterLoss-kettleLoss-EvL-fermentationLoss))
                waterGraph <- ggplot(data = waterData, aes(step,vol))
                waterGraph + ggtitle("Total Water Needed") + geom_step()
        })
        
}