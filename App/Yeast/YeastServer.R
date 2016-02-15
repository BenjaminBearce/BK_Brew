# Yeast Server

#the while loop
whileLoop <- function(input, currentCellCount, desiredCells, totalVol, nextVol){
        while(currentCellCount < desiredCells){
                
                totalVol <- totalVol + nextVol
                nextVol <- nextVol*2
                currentCellCount <- currentCellCount*2
                
                if(currentCellCount*2 > desiredCells){
                        remainder <- ifelse(currentCellCount == 0,0,desiredCells/currentCellCount)
                        nextVol <- (remainder-1)*nextVol/2
                        totalVol <- totalVol + nextVol
                        currentCellCount <- currentCellCount*remainder  
                }
        }
        totalVol
                
}

yeastServer <- function(input, output, session){
       
        output$attenuation <- renderUI({
                numericInput(inputId = "attenuation",
                             label = "Attenuation (%)",
                             value = filter(Yeast, YeastStrain == input$Yeast) %>% select(ATT))
        })
        
        output$ABV <- renderText({
                #Calc OG
                lowerRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeLow)) - 1)*1000
                higherRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeHigh)) - 1)*1000
                
                OG <- mean(c(lowerRange,higherRange))/1000 + 1
                ATT <- input$attenuation
                FG <- OG-(ATT/100)*(OG-1)
                ABV = (1.05/0.79)*((OG-FG)/FG)*100
        })
        
        output$FG <- renderUI({
                #Calc OG
                lowerRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeLow)) - 1)*1000
                higherRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeHigh)) - 1)*1000
                
                OG <- mean(c(lowerRange,higherRange))/1000 + 1
                ATT <- input$attenuation
                FG <- OG-(ATT/100)*(OG-1)
                
                numericInput(inputId = "FG",
                             label = "Final Gravity",
                             value = FG)
        })
        
        output$FGRange <- renderText({
                #Calc Gravity Range
                lowerRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeLow)) - 1)*1000
                higherRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeHigh)) - 1)*1000      
                
                paste(lowerRange/1000+1,"-",higherRange/1000+1)
        })
        
        cellsNeeded <- reactive({
                #Calc OG
                lowerRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeLow)) - 1)*1000
                higherRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeHigh)) - 1)*1000
                
                OG <- mean(c(lowerRange,higherRange))
                degreePlato <- OG/4
                
                # Recommended that you use (1e6 cells)/(degreePlate*milliliter) or 1B/(P*L)
                batchSize <- input$batchSize
                literBatchSize <- batchSize*3.785 #Liters in a gallon
                cellDensity <- (1e9*degreePlato*literBatchSize)
        })
        
        output$cellsNeeded <- renderText({cellsNeeded()/1e9}) #show in Billions
        
        litersNeeded <- reactive({
                desiredCells <- cellsNeeded()
                startingCells <- input$startYeastCells*1e9
                currentCellCount <- startingCells
                
                rateForYeast <- 1/(50e9) # L/Billion to double 
                
                
                initialVol <- rateForYeast*startingCells # L
                nextVol <- initialVol
                totalVol <- 0
                
                if(currentCellCount*2 > desiredCells){
                        remainder <- ifelse(currentCellCount == 0,0,desiredCells/currentCellCount)
                        nextVol <- (remainder-1)*nextVol/2
                        totalVol <- totalVol + nextVol
                        currentCellCount <- currentCellCount*remainder 
                        
                        #Return totalVol
                        totalVol
                }else{
                        #Returns totalVol
                        whileLoop(input, currentCellCount, desiredCells, totalVol, nextVol)
                        
                }
                
        })
        
        
        output$litersNeeded <- renderText({
                litersNeeded()
        })
}


