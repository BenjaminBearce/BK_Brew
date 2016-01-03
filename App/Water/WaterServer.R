# Water Server

waterServer <- function(input, output){
        #Constants that are dynamic
        grainLoss <- reactive({
                totalGrain()*input$grainAbsorptionFactor
        })
        
        lauterLoss <- reactive({
                input$lauterTunDeadSpace
        })
        mashLoss <- reactive({
                input$mashTunDeadSpace
        })
        kettleLoss <- reactive({
                input$kettleDeadSpace
        })
        fermentationLoss <- reactive({
                input$fermentationTankLoss
        })
        BS <- reactive({
                input$batchSize      
        })
        EvL <- reactive({
                BS()*((input$boilTime/60)*(input$evap/100)/(1-(input$boilTime/60)*(input$evap/100)))
        })
        EL <- reactive({
                lauterLoss() + mashLoss() + kettleLoss() + fermentationLoss()
        })
        TWN <- reactive({
                #grainLoss() + EL() + BS() + EvL()
                
                ((BS()+input$kettleDeadSpace + input$fermentationTankLoss)/((1-input$shrink/100)*(1-(input$boilTime/60)*(input$evap/100)))) + input$lauterTunDeadSpace + input$mashTunDeadSpace + grainLoss()
        })
        
        #Output objects
        output$waterTotalWaterNeeded <- renderText({
                TWN()
        })
        
        output$waterGrainLoss <- renderText({
                grainLoss()
        })
        
        output$waterEquipLoss <- renderText({
                EL()
        })
        
        output$waterEvapLoss <- renderText({
                EvL()
        })
        
        
        output$waterBatchSize <- renderText({
                BS()
        })
        
        output$waterGraph <- renderPlot({
              
                print("GL")
                grainLoss() 
                print("EL")
                EL() 
                print("BS")
                BS() 
                print("EvL")
                EvL() 
                print("TWN")
                TWN() 
                
#                 waterData <- data.frame(step = 1:6,
#                                         TWN = ,
#                                         PostMash = ,
#                                         PostSparge = ,
#                                         PostBoil = ,
#                                         Cooling = ,
#                                         Fermentation = )
                
                
                waterData <- data.frame(step = seq(1,6), vol = c(TWN(),
                                                                 TWN()-grainLoss(),
                                                                 TWN()-grainLoss()-mashLoss(),
                                                                 TWN()-grainLoss()-mashLoss()-lauterLoss(),
                                                                 TWN()-grainLoss()-mashLoss()-lauterLoss()-kettleLoss()-EvL(),
                                                                 TWN()-grainLoss()-mashLoss()-lauterLoss()-kettleLoss()-EvL()-fermentationLoss()))
                waterGraph <- ggplot(data = waterData, aes(step,vol))
                waterGraph + ggtitle("Total Water Needed") + geom_step()
        })
        
}