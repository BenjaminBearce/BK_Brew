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
        grainInfo <- reactive({
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
        output$grainInfo <- renderTable({grainInfo()})
        ### Step 3 Variables and Output -----
        
        effAlkalinity <- reactive({
                if("Not Bicarbonate" == "Bicarbonate"){ratio = 56/61}else if("Alkalinity" == "Alkalinity"){ratio = 1}
                #(1-%Distilled)*(HCO3 or CaCO3) #ppm
                (1)*input$HCO3_CaCO3*ratio+ 
                        
                        (
                                (input$mashChalk*130)+
                                        (input$mashBakingSoda*157)-
                                        (176.1*input$lacticAcidPercent/100*input$lacticAcidml*2)-
                                        (4160.4*input$acidulatedMaltPercent/100*input$acidulatedMaltOz)*2.5+
                                        (input$mashSlakedLime)*357
                        )/(input$chemistryMashVol)
        })
        
        output$effAlkalinity <- renderText({
                effAlkalinity()
               
#                  print("start")
#                  print(input$mashChalk)
#                  print(input$mashBakingSoda)
#                  print(input$lacticAcidPercent/100)
#                  print(input$lacticAcidml)
#                  print(input$acidulatedMaltPercent/100)
#                  print(input$acidulatedMaltOz)
#                  print(input$mashSlakedLime)
#                  print(input$chemistryMashVol)

               
        })
        resAlkalinity <- reactive({
                 effAlkalinity() - ((mashCa()/1.4)+(mashMg()/1.7)) #ppm
        })
        output$resAlkalinity <- renderText({resAlkalinity()})
        
        output$pH <- renderText({
                #as.numeric(sum(grainInfo()$Lbs))
                pH <- grainInfo() %>%
                        mutate(Lbs_x_distWaterPH = Lbs*distWaterpH) %>%
                        .[complete.cases(.),] %>%
                        select(Lbs_x_distWaterPH)/totalGrain() %>%
                        as.numeric() + (0.1085*input$chemistryMashVol/totalGrain()+0.013)*resAlkalinity()/50
                pH[1,1]
                #estimatedPH <- estimatedPH[complete.cases(estimatedPH),]
                
                #select(estimatedPH,Lbs_x_distWaterPH) %>% sum() %>% as.numeric()
#                         mutate(Lbs_x_distWaterPH = Lbs*distWaterpH) %>%
#                         select(Lbs_x_distWaterPH) %>%
#                         sum() %>% as.numeric()
#                 estimatedPH <- sum(estimatedPH$Lbs_x_distWaterPH)/sum(estimatedPH$Lbs)+
#                                (0.1085*input$chemistryMashVol/sum(estimatedPH$Lbs)+0.013)*
#                                resAlkalinity()/50 
                
                
        })
        
        output$pHSuggestion <- renderText({
                "5.4 - 5.6"
        })
        ### Step 4 Variables and Output -----
        #(a) - Adjusting pH Down
        #mash
        #spargeGypsum <- eventReactive(input$checkGypsum,{input$Ca})
        spargeGypsum <- reactive({
                ifelse(input$checkGypsum,
                       input$mashGypsum*(input$chemistrySpargeVol/input$chemistryMashVol),
                       0)
        })
        spargeCalciumChloride <- reactive({
                ifelse(input$checkCalciumChloride,
                       input$mashCalciumChloride*(input$chemistrySpargeVol/input$chemistryMashVol),
                       0)
        })
        spargeEpsomSalt <- reactive({
                ifelse(input$checkEpsomSalt,
                       input$mashEpsomSalt*(input$chemistrySpargeVol/input$chemistryMashVol),
                       0)
        })
        
        output$spargeGypsum <- renderText({spargeGypsum()})
        output$spargeCalciumChloride <- renderText({spargeCalciumChloride()})
        output$spargeEpsomSalt <- renderText({spargeEpsomSalt()})
        
        #(b) - Adjusting pH Up
        #mash
        spargeSlakedLime <- reactive({
                ifelse(input$checkSlakedLime,
                       input$mashSlakedLime*(input$chemistrySpargeVol/input$chemistryMashVol),
                       0)
        })
        spargeBakingSoda <- reactive({
                ifelse(input$checkBakingSoda,
                       input$mashBakingSoda*(input$chemistrySpargeVol/input$chemistryMashVol),
                       0)
        })
        spargeChalk <- reactive({
                ifelse(input$checkChalk,
                       input$mashChalk*(input$chemistrySpargeVol/input$chemistryMashVol),
                       0)
        })
        
        output$spargeSlakedLime <- renderText({spargeSlakedLime()})
        output$spargeBakingSoda <- renderText({spargeSlakedLime()})
        output$spargeChalk <- renderText({spargeChalk()})
        
        ### Step 5 Variables and Output -----
        #Mash Profile
        
        mashCa <- reactive({
                (1)* #1-%Distilled
                (input$Ca)+
                (input$mashChalk*105.89+
                 input$mashGypsum*60+
                 input$mashCalciumChloride*72+
                 input$mashSlakedLime*143)/input$chemistryMashVol
        })
        mashMg <- reactive({
                (1)*
                (input$Mg)+
                (input$mashEpsomSalt*24.6)/input$chemistryMashVol
        })
        mashNa <- reactive({
                (1)*
                (input$Na)+
                (input$mashBakingSoda*72.3)/input$chemistryMashVol
        })
        mashCl <- reactive({
                (1)*
                (input$Cl)+
                (input$mashCalciumChloride*127.47)/input$chemistryMashVol
        })
        mashSO4 <- reactive({
                (1)*
                (input$SO4)+
                (input$mashGypsum*147.4+input$mashEpsomSalt*103)/input$chemistryMashVol
        })
        
        output$mashCalcium <- renderText({mashCa()})
        output$mashMagnesium <- renderText({mashMg()})
        output$mashSodium <- renderText({mashNa()})
        output$mashChloride <- renderText({mashCl()})
        output$mashSulfate <- renderText({mashSO4()})
        output$mashChlorideSulfate <- renderText({mashCl()/mashSO4()})
        #Mash and Sparge Profile
        
        M_SCalcium <- reactive({
                if(input$chemistrySpargeVol == 0){
                        M_SCalcium <- mashCa()
                        
                }else{
                        M_SCalcium <- (1-(input$mashPercentDistilled*input$chemistryMashVol+input$spargePercentDistilled*input$chemistrySpargeVol)/
                                               (input$chemistryMashVol+input$chemistrySpargeVol)
                        )*input$Ca+
                                ((input$mashChalk+spargeChalk())*105.89+
                                         (input$mashGypsum+spargeGypsum())*60+
                                         (input$mashCalciumChloride+spargeCalciumChloride())*72+
                                         (input$mashSlakedLime+spargeSlakedLime())*143)/(input$chemistryMashVol+input$chemistrySpargeVol)
                        
                }
                M_SCalcium
        })
        M_SMagnesium <- reactive({
                if(input$chemistrySpargeVol == 0){
                        M_SMagnesium <- mashCa()
                        
                }else{
                        M_SMagnesium <- (1-(input$mashPercentDistilled*input$chemistryMashVol+input$spargePercentDistilled*input$chemistrySpargeVol)/
                                                 (input$chemistryMashVol+input$chemistrySpargeVol)
                        )*input$Mg+
                                ((input$mashEpsomSalt+spargeEpsomSalt())*24.6)/
                                (input$chemistryMashVol+input$chemistrySpargeVol)
                        
                }
                M_SMagnesium
        })
        M_SSodium <- reactive({
                if(input$chemistrySpargeVol == 0){
                        M_SSodium <- mashCa()
                        
                }else{
                        M_SSodium <- (1-(input$mashPercentDistilled*input$chemistryMashVol+input$spargePercentDistilled*input$chemistrySpargeVol)/
                                              (input$chemistryMashVol+input$chemistrySpargeVol)
                        )*input$Na+
                                ((input$mashBakingSoda+spargeBakingSoda())*72.3)/
                                (input$chemistryMashVol+input$chemistrySpargeVol)
                        
                }
                M_SSodium
        })
        M_SChloride <- reactive({
                if(input$chemistrySpargeVol == 0){
                        M_SChloride <- mashCa()
                        
                }else{
                        M_SChloride <- (1-(input$mashPercentDistilled*input$chemistryMashVol+input$spargePercentDistilled*input$chemistrySpargeVol)/
                                                (input$chemistryMashVol+input$chemistrySpargeVol)
                        )*input$Cl+
                                ((input$mashCalciumChloride+spargeCalciumChloride())*127.47)/
                                (input$chemistryMashVol+input$chemistrySpargeVol)
                        
                }
                M_SChloride
        })
        M_SSulfate <- reactive({
                if(input$chemistrySpargeVol == 0){
                        M_SSulfate <- mashCa()
                        
                }else{
                        M_SSulfate <- (1-(input$mashPercentDistilled*input$chemistryMashVol+input$spargePercentDistilled*input$chemistrySpargeVol)/
                                               (input$chemistryMashVol+input$chemistrySpargeVol)
                        )*input$SO4+
                                ((input$mashGypsum+spargeGypsum())*147.4+
                                         (input$mashEpsomSalt+spargeEpsomSalt())*103)/
                                (input$chemistryMashVol+input$chemistrySpargeVol)
                        
                }
                M_SSulfate
        })
        M_SChlorideSulfate <- reactive({
               M_SChloride()/M_SSulfate()
        })
        output$M_SCalcium <- renderText({M_SCalcium()})
        output$M_SMagnesium <- renderText({M_SMagnesium()})
        output$M_SSodium <- renderText({M_SSodium()})
        output$M_SChloride <- renderText({M_SChloride()})
        output$M_SSulfate <- renderText({M_SSulfate()})
        output$M_SChlorideSulfate <- renderText({M_SChlorideSulfate()})
        
        #Palmer's Recommened Ranges
        output$recommendedCalcium <- renderText({"50-100"})
        output$recommendedMagnesium <- renderText({"10-30"})
        output$recommendedSodium <- renderText({"0-150"})
        output$recommendedChloride <- renderText({"0-250"})
        output$recommendedSulfate <- renderText({"50-350"})
        output$recommendedChlorideSulfate <- renderText({"*"})
        
        #Chloride / Sulfate Ratio Check
        output$Chl_SO4_Ratio_Message <- renderText({
                if(M_SChlorideSulfate() < 0.77){
                        "Below .77, May enhance bitterness"
                }else if(M_SChlorideSulfate() < 1.3){
                        ".77 to 1.3 = Balanced"
                }else{
                        "Above 1.3 may enhance maltiness"
                }
        })
        
        
        
        
}