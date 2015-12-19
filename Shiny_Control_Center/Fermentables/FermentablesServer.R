# Fermentables Server

fermentablesServer <- function(input, output){
        output$OG1 <- renderText({
                OG <- as.character(subset(Styles, Styles == input$Style, select = GravityRange))
                OG <- OG %>%
                        str_split("-") %>%
                        unlist() %>%
                        as.numeric()
                
                lowerRange <- (OG[1]-1)*1000
                higherRange <- OG[2]
                
                OG <- mean(c(lowerRange,higherRange)) #/1000+1
                
                totalGravity <- OG*input$batchSize #OG*Gal
                
                grains <- Grains %>% 
                        filter(Ingredients == input$Ingredients1) %>% 
                        mutate(IngredientGravity = input$IngredientPercent1/100*totalGravity) %>%
                        mutate(lbsNeeded = IngredientGravity/((PPG-1)*1000*input$sysEfficiency/100)) %>%
                        select(lbsNeeded) %>% as.character()
        })
        
        output$OG2 <- renderText({
                OG <- as.character(subset(Styles, Styles == input$Style, select = GravityRange))
                OG <- OG %>%
                        str_split("-") %>%
                        unlist() %>%
                        as.numeric()
                
                lowerRange <- (OG[1]-1)*1000
                higherRange <- OG[2]
                
                OG <- mean(c(lowerRange,higherRange)) #/1000+1
                
                totalGravity <- OG*input$batchSize #OG*Gal
                
                grains <- Grains %>% 
                        filter(Ingredients == input$Ingredients2) %>% 
                        mutate(IngredientGravity = input$IngredientPercent2/100*totalGravity) %>%
                        mutate(lbsNeeded = IngredientGravity/((PPG-1)*1000*input$sysEfficiency/100)) %>%
                        select(lbsNeeded) %>% as.character()
        })
        
        output$OG3 <- renderText({
                OG <- as.character(subset(Styles, Styles == input$Style, select = GravityRange))
                OG <- OG %>%
                        str_split("-") %>%
                        unlist() %>%
                        as.numeric()
                
                lowerRange <- (OG[1]-1)*1000
                higherRange <- OG[2]
                
                OG <- mean(c(lowerRange,higherRange)) #/1000+1
                
                totalGravity <- OG*input$batchSize #OG*Gal
                
                grains <- Grains %>% 
                        filter(Ingredients == input$Ingredients3) %>% 
                        mutate(IngredientGravity = input$IngredientPercent3/100*totalGravity) %>%
                        mutate(lbsNeeded = IngredientGravity/((PPG-1)*1000*input$sysEfficiency/100)) %>%
                        select(lbsNeeded) %>% as.character()
        })
        
        output$OG4 <- renderText({
                OG <- as.character(subset(Styles, Styles == input$Style, select = GravityRange))
                OG <- OG %>%
                        str_split("-") %>%
                        unlist() %>%
                        as.numeric()
                
                lowerRange <- (OG[1]-1)*1000
                higherRange <- OG[2]
                
                OG <- mean(c(lowerRange,higherRange)) #/1000+1
                
                totalGravity <- OG*input$batchSize #OG*Gal
                
                grains <- Grains %>% 
                        filter(Ingredients == input$Ingredients4) %>% 
                        mutate(IngredientGravity = input$IngredientPercent4/100*totalGravity) %>%
                        mutate(lbsNeeded = IngredientGravity/((PPG-1)*1000*input$sysEfficiency/100)) %>%
                        select(lbsNeeded) %>% as.character()
        })
        
        output$OG5 <- renderText({
                OG <- as.character(subset(Styles, Styles == input$Style, select = GravityRange))
                OG <- OG %>%
                        str_split("-") %>%
                        unlist() %>%
                        as.numeric()
                
                lowerRange <- (OG[1]-1)*1000
                higherRange <- OG[2]
                
                OG <- mean(c(lowerRange,higherRange)) #/1000+1
                
                totalGravity <- OG*input$batchSize #OG*Gal
                
                grains <- Grains %>% 
                        filter(Ingredients == input$Ingredients5) %>% 
                        mutate(IngredientGravity = input$IngredientPercent5/100*totalGravity) %>%
                        mutate(lbsNeeded = IngredientGravity/((PPG-1)*1000*input$sysEfficiency/100)) %>%
                        select(lbsNeeded) %>% as.character()
        })
        data <- reactive({
                #Style OG
                OG <- as.character(subset(Styles, Styles == input$Style, select = GravityRange))
                OG <- OG %>%
                        str_split("-") %>%
                        unlist() %>%
                        as.numeric()
                
                lowerRange <- (OG[1]-1)*1000
                higherRange <- OG[2]
                
                OG <- mean(c(lowerRange,higherRange)) #/1000+1
                
                totalGravity <- OG*input$batchSize #OG*Gal
                #Grains
                grains1 <- Grains %>% 
                        filter(Ingredients == input$Ingredients1) %>% 
                        mutate(IngredientGravity = input$IngredientPercent1/100*totalGravity) %>%
                        mutate(lbsNeeded = IngredientGravity/((PPG-1)*1000*input$sysEfficiency/100)) %>%
                        select(lbsNeeded) %>% as.numeric()
                grains2 <- Grains %>% 
                        filter(Ingredients == input$Ingredients2) %>% 
                        mutate(IngredientGravity = input$IngredientPercent2/100*totalGravity) %>%
                        mutate(lbsNeeded = IngredientGravity/((PPG-1)*1000*input$sysEfficiency/100)) %>%
                        select(lbsNeeded) %>% as.numeric() 
                grains3 <- Grains %>% 
                        filter(Ingredients == input$Ingredients3) %>% 
                        mutate(IngredientGravity = input$IngredientPercent3/100*totalGravity) %>%
                        mutate(lbsNeeded = IngredientGravity/((PPG-1)*1000*input$sysEfficiency/100)) %>%
                        select(lbsNeeded) %>% as.numeric()
                grains4 <- Grains %>% 
                        filter(Ingredients == input$Ingredients4) %>% 
                        mutate(IngredientGravity = input$IngredientPercent4/100*totalGravity) %>%
                        mutate(lbsNeeded = IngredientGravity/((PPG-1)*1000*input$sysEfficiency/100)) %>%
                        select(lbsNeeded) %>% as.numeric()
                grains5 <- Grains %>% 
                        filter(Ingredients == input$Ingredients5) %>% 
                        mutate(IngredientGravity = input$IngredientPercent5/100*totalGravity) %>%
                        mutate(lbsNeeded = IngredientGravity/((PPG-1)*1000*input$sysEfficiency/100)) %>%
                        select(lbsNeeded) %>% as.numeric() 
                
                lbs <- as.numeric(grains1+grains2+grains3+grains4+grains5)
        })
        output$data <- renderText({
                data()
        })
}