# Chemistry Server

chemistryServer <- function(input, output){
        output$pH <- renderText({
                estimatedPH <- 5.8 + (input$HCO3_CaCO3*0.056 - input$Ca*0.04 - input$Mg*0.033)*0.028
        })
        
        #we have inputs for 
        #Ca - using
        #Mg - using
        #NA - not using
        #Cl - not using
        #SO4 - not using
        #HCO3_CaCO3 - using
        
        output$grainInfo <- renderTable({
                #Grain Type and Distilled Water pH
                grainDistpH <- data.frame(grainTypes = 1:11,
                                          distWaterpH = c(0,
                                                          5.7,
                                                          5.79,
                                                          5.77,
                                                          5.43,
                                                          5.75,
                                                          6.04,
                                                          5.56,
                                                          5.70,
                                                          NA,
                                                          4.71))
                
                #Grains
                ingredients <- c(input$Ingredients1,
                                 input$Ingredients2,
                                 input$Ingredients3,
                                 input$Ingredients4,
                                 input$Ingredients5)
                
                #Lbs
                lbs <- as.numeric(c(grains1(),
                                    grains2(),
                                    grains3(),
                                    grains4(),
                                    grains5()))
                #EZ Water Code
                ezWaterCode <- as.numeric(c(filter(Grists, Ingredients == input$Ingredients1) %>% select(EZWaterCode),
                                          filter(Grists, Ingredients == input$Ingredients2) %>% select(EZWaterCode),
                                          filter(Grists, Ingredients == input$Ingredients3) %>% select(EZWaterCode),
                                          filter(Grists, Ingredients == input$Ingredients4) %>% select(EZWaterCode),
                                          filter(Grists, Ingredients == input$Ingredients5) %>% select(EZWaterCode)))
                #SRM
                srm <- as.numeric(c(filter(Grists, Ingredients == input$Ingredients1) %>% select(SRM),
                                    filter(Grists, Ingredients == input$Ingredients2) %>% select(SRM),
                                    filter(Grists, Ingredients == input$Ingredients3) %>% select(SRM),
                                    filter(Grists, Ingredients == input$Ingredients4) %>% select(SRM),
                                    filter(Grists, Ingredients == input$Ingredients5) %>% select(SRM)))
                
                #Distilled Water Mash pH
                distWaterMashpH <- 
                
                data.frame(Ingredients =ingredients, 
                           Lbs = lbs, 
                           SRM = srm,
                           EZWaterCode = ezWaterCode) %>%
                        left_join(y = grainDistpH, by = c("EZWaterCode" = "grainTypes")) %>%
                        mutate(distWaterpH = ifelse(ezWaterCode == 10, 5.22-0.00504*srm,distWaterpH))
        })
}