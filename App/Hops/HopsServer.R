# Hops Server

# Initialize average alpha acid function
avgAlphaAcid <- function(input, hopChoice){
        alphaLow <- Hops %>% 
                filter(Hops == hopChoice) %>%
                select(AlphaLow) %>%
                as.numeric()
        
        alphaHigh <- Hops %>% 
                filter(Hops == hopChoice) %>%
                select(AlphaHigh) %>%
                as.numeric()
        
        defaultAlpha <- mean(c(alphaLow, alphaHigh))
}

utilization <- function(input, boilTime, boilGravity){
        func_of_gravity <- 1.65*0.000125^(boilGravity-1)
        func_of_time <- (1-exp(-0.04*boilTime))/4.15
        func_of_gravity*func_of_time
}

hopsServer <- function(input, output, session){
        
        # Hop Alpha Acid -----
        
        output$hopsAlphaAcidOne <- renderUI({
                numericInput(inputId = "AlphaAcid1",
                             label = "AlphaAcid (%)",
                             value = avgAlphaAcid(input, input$Hops1))
        })
        output$hopsAlphaAcidTwo <- renderUI({
                numericInput(inputId = "AlphaAcid2",
                             label = NULL,
                             value = avgAlphaAcid(input, input$Hops2))
        })
        output$hopsAlphaAcidThree <- renderUI({
                numericInput(inputId = "AlphaAcid3",
                             label = NULL,
                             value = avgAlphaAcid(input, input$Hops3))
        })
        output$hopsAlphaAcidFour <- renderUI({
                numericInput(inputId = "AlphaAcid4",
                             label = NULL,
                             value = avgAlphaAcid(input, input$Hops4))
        })
        output$hopsAlphaAcidFive <- renderUI({
                numericInput(inputId = "AlphaAcid5",
                             label = NULL,
                             value = avgAlphaAcid(input, input$Hops5))
        })
        
        # Hop Utilization -----
        
        output$hopsUtilization1 <- renderText({
                utilization(input, input$BoilTime1, boilGravity())*100
                
        })
        output$hopsUtilization2 <- renderText({
                utilization(input, input$BoilTime2, boilGravity())*100
        })
        output$hopsUtilization3 <- renderText({
                utilization(input, input$BoilTime3, boilGravity())*100
        })
        output$hopsUtilization4 <- renderText({
                utilization(input, input$BoilTime4, boilGravity())*100
        })
        output$hopsUtilization5 <- renderText({
                utilization(input, input$BoilTime5, boilGravity())*100
                
        })
        
        # Hop IBU -----
        
        output$hopsIBU1 <- renderText({
                #AAU alpha acid units
                AUU <- input$AlphaAcid1/100*input$Weight1
                utilization(input, input$BoilTime1, boilGravity())*AUU*7489/input$batchSize
        })
        output$hopsIBU2 <- renderText({
                #AAU alpha acid units
                AUU <- input$AlphaAcid2/100*input$Weight2
                utilization(input, input$BoilTime2, boilGravity())*AUU*7489/input$batchSize
        })
        output$hopsIBU3 <- renderText({
                #AAU alpha acid units
                AUU <- input$AlphaAcid3/100*input$Weight3
                utilization(input, input$BoilTime3, boilGravity())*AUU*7489/input$batchSize
        })
        output$hopsIBU4 <- renderText({
                #AAU alpha acid units
                AUU <- input$AlphaAcid4/100*input$Weight4
                utilization(input, input$BoilTime4, boilGravity())*AUU*7489/input$batchSize
        })
        output$hopsIBU5 <- renderText({
                #AAU alpha acid units
                AUU <- input$AlphaAcid5/100*input$Weight5
                utilization(input, input$BoilTime5, boilGravity())*AUU*7489/input$batchSize
        })
        
#         utilization <- reactive({
#                func_of_gravity <- 1.65*0.000125^(boilGravity()-1)
#                func_of_time <- (1-exp(-0.04*input$BoilTime1))/4.15
#                func_of_gravity*func_of_time
#         })
        
        boilGravity <- reactive({
                lowerRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeLow)) - 1)*1000
                higherRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeHigh)) - 1)*1000
                
                OG <- mean(c(lowerRange,higherRange))/1000+1
                OG
#                 OG - filter(GravityVersusTemp, Temperature_F == 212) %>%
#                         select(Add_SG) %>%
#                         as.numeric()
        })
        
        # Boil Gravity -----
        output$hopsBoilGravity <- renderText({
                boilGravity()
        })
}



