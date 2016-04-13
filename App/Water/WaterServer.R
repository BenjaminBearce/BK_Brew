# Water Server

waterServer <- function(input, output){
        #Constants that are dynamic
        grainLoss <- reactive({
                totalGrain()*input$grainAbsorptionFactor*(1-input$shrink/100)
        })
        
        lauterLoss <- reactive({
                input$lauterTunDeadSpace*(1-input$shrink/100)
        })
        mashLoss <- reactive({
                input$mashTunDeadSpace*(1-input$shrink/100)
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
                grainLoss() + EL() + BS() + EvL()
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
        
        output$waterMashVol <- renderText({
                input$mashThickness*totalGrain()/4 #[Qts/Lbs]*[Lbs]*[1Gal/4Qts] = Gal
        })
        
        spargeVol <<- reactive({5})
        
        output$waterSpargeVol <- renderText({
                spargeVol() #Hard Coded 
                # input$mashThickness*totalGrain()/4 #[Qts/Lbs]*[Lbs]*[1Gal/4Qts] = Gal
        })
        
        output$waterGraph <- renderPlot({
              #Just here to see what the values are in consol
#                 print("GL")
#                 grainLoss() 
#                 print("EL")
#                 EL() 
#                 print("BS")
#                 BS() 
#                 print("EvL")
#                 EvL() 
#                 print("TWN")
#                 TWN() 
                
                waterData <- data.frame(x = factor(c("TWN",
                                                     "PostMash",
                                                     "PostSparge",
                                                     "PostBoil",
                                                     "Cooling",
                                                     "Fermentation"),
                                                   ordered = T,
                                                   levels = c("TWN",
                                                              "PostMash",
                                                              "PostSparge",
                                                              "PostBoil",
                                                              "Cooling",
                                                              "Fermentation")),
                                        y = c(TWN(),
                                              TWN()-grainLoss(),
                                              TWN()-grainLoss()-mashLoss(),
                                              TWN()-grainLoss()-mashLoss()-lauterLoss(),
                                              TWN()-grainLoss()-mashLoss()-lauterLoss()-kettleLoss()-EvL(),
                                              TWN()-grainLoss()-mashLoss()-lauterLoss()-kettleLoss()-EvL()-fermentationLoss())
                                        )
                #class(waterData)
                ggplot(data = waterData, aes(x,y)) +
                        geom_bar(stat = "identity", fill = I("grey50")) +
                        ggtitle("Total Water Needed")
                

        })
        
}