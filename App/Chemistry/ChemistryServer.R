# Chemistry Server

chemistryServer <- function(input, output){
        ### Step 1 Variables and Output -----
        
        #we have inputs for 
        #Ca - using
        #Mg - using
        #NA - not using
        #Cl - not using
        #SO4 - not using
        #HCO3 or CaCO3 - using
        #still need % of mash and sparge that is distilled
        
        output$chemistryMashVol <- renderUI({
                numericInput(inputId = "chemistryMashVol",label = "Mash Volume (Gal):",value = input$mashThickness*totalGrain()/4) #[Qts/Lbs]*[Lbs]*[1Gal/4Qts] = Gal
        })
        
        output$chemistrySpargeVol <- renderUI({
                numericInput(inputId = "chemistrySpargeVol",label = "Sparge Volume (Gal):",value = spargeVol()) #from water server
        })
        
        ### Step 2 Variables and Output -----
        
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
                
                #Mash Volume
                #                 output$chemistryMashVol <- renderText({
                #                         input$mashThickness*totalGrain()/4 #[Qts/Lbs]*[Lbs]*[1Gal/4Qts] = Gal
                #                 })
                
                #Sparge Volume
                #                 output$chemistrySpargeVol <- renderText({
                #                         spargeVol() #from water server 
                #                 })
                
                data.frame(Ingredients =ingredients, 
                           Lbs = lbs, 
                           SRM = srm,
                           EZWaterCode = ezWaterCode) %>%
                        left_join(y = grainDistpH, by = c("EZWaterCode" = "grainTypes")) %>%
                        mutate(distWaterpH = ifelse(ezWaterCode == 10, 5.22-0.00504*srm,distWaterpH)) %>%
                        select(Ingredients,Lbs,SRM,distWaterpH)
        })
        ### Step 3 Variables and Output -----
        
        output$effAlkalinity <- renderText({
                
                (1)*input$HCO3_CaCO3* # (1-%Distilled)*(HCO3 or CaCO3) #ppm
                if("Not Alkalinity" == "Alkalinity"){56/61}else if("Bicarbonate" == "Bicarbonate"){1}+
                (
                         (input$Ca*130)+
                         (input$Mg*157)-
                         (1)-
                         (1)+
                         (1)
                 )/(1)
                
#                 (1-%Distilled)*(HCO3 or CaCO3) #ppm
#                 *
#                         if(Alkalinity){50/61}elseif(0 | Bicarbonate){1}else{print("Error")} #ppm
#                 +
#                         ((CaCO3*130)#grams
#                          +
#                                  (NaHCO3*157)#grams
#                          -
#                                  (176.1*lacticAcid[%]*lacticAcid[ml]*2)
#                          -
#                                  (4160.4*acidulatedMalt[%]*acidulatedMalt[oz.])*2.5
#                          +
#                                  (Ca(OH)2)*357 #grams
#                         )/mashVolume
               
        })
        
        output$resAlkalinity <- renderText({
                "resAlkalinity"
        })
        
        output$pH <- renderText({
                estimatedPH <- 5.8 + (input$HCO3_CaCO3*0.056 - input$Ca*0.04 - input$Mg*0.033)*0.028
        })
        
        output$pHSuggestion <- renderText({
                "5.4 - 5.6"
        })
        ### Step 4 Variables and Output -----
        #(a) - Adjusting pH Down
        output$spargeGypsum <- renderText({"Gypsum"})
        output$spargeCalciumChloride <- renderText({"CalciumChloride"})
        output$spargeEpsomSalt <- renderText({"EpsomSalt"})
        #(b) - Adjusting pH Up
        output$spargeSlakedLime <- renderText({"Slaked Lime"})
        output$spargeBakingSoda <- renderText({"Baking Soda"})
        output$spargeChalk <- renderText({"Chalk"})
        
        
        ### Step 5 Variables and Output -----
        #Mash Profile
        output$mashCalcium <- renderText({"0"})
        output$mashMagnesium <- renderText({"0"})
        output$mashSodium <- renderText({"0"})
        output$mashChloride <- renderText({"0"})
        output$mashSulfate <- renderText({"0"})
        output$mashChlorideSulfate <- renderText({"0"})
        #Mash and Sparge Profile
        output$M_SCalcium <- renderText({"0"})
        output$M_SMagnesium <- renderText({"0"})
        output$M_SSodium <- renderText({"0"})
        output$M_SChloride <- renderText({"0"})
        output$M_SSulfate <- renderText({"0"})
        output$M_SChlorideSulfate <- renderText({"0"})
        #Palmer's Recommened Ranges
        output$recommendedCalcium <- renderText({"50-100"})
        output$recommendedMagnesium <- renderText({"10-30"})
        output$recommendedSodium <- renderText({"0-150"})
        output$recommendedChloride <- renderText({"0-250"})
        output$recommendedSulfate <- renderText({"50-350"})
        output$recommendedChlorideSulfate <- renderText({"cond."})
        

        
        
        
        
}