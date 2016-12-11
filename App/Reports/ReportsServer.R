# Saving and Loading functions...Reports Server is down below them

library(RSQLite)
sqlitePath <- "../../Database/Recipes.sqlite"

saveData <- function(data,table) {
  # Connect to the database
  db <- dbConnect(SQLite(), sqlitePath)
  # Construct the update query by looping over the data fields
  query <- list()
  
  for(row in 1:nrow(data)){
    
    query[row] <- sprintf(
      "INSERT INTO %s (%s) VALUES ('%s')",
      table, 
      paste(names(data[row,]), collapse = ", "),
      paste(data[row,], collapse = "', '")
    )
    
    dbGetQuery(db, query[[row]])
    
  }
  # Submit the update query and disconnect
  dbDisconnect(db)
}  

# saveData <- function(data,table) {
#         # Connect to the database
#         db <- dbConnect(SQLite(), sqlitePath)
#         # Construct the update query by looping over the data fields
#         query <- sprintf(
#                 "INSERT INTO %s (%s) VALUES ('%s')",
#                 table, 
#                 paste(names(data), collapse = ", "),
#                 paste(data, collapse = "', '")
#         )
#         # Submit the update query and disconnect
#         dbGetQuery(db, query)
#         dbDisconnect(db)
# }

# loadData <- function() {
#         # Connect to the database
#         db <- dbConnect(SQLite(), sqlitePath)
#         # Construct the fetching query
#         query <- sprintf("SELECT * FROM %s", table)
#         # Submit the fetch query and disconnect
#         data <- dbGetQuery(db, query)
#         dbDisconnect(db)
#         data
# }




# Reports Server

reportsServer <- function(input, output, session){
    
#Things to find:

        #Chemistry Table
        chemistryData <- reactive({
          Chemistry <- data.frame(Recipe = input$recipe,
                                  Init_Ca = input$Ca,
                                  Init_Mg = input$Mg,
                                  Init_Na = input$Na,
                                  Init_Cl = input$Cl,
                                  Init_SO4 = input$SO4,
                                  Init_HCO3_CaCO3 = input$HCO3_CaCO3,
                                  Estimated_pH = pH(),
                                  Effective_Alkalinity = effAlkalinity(),
                                  Residual_Alkalinity = resAlkalinity(),
                                  ph_UP_Gypsum_CaSO4 = input$mashGypsum,
                                  ph_UP_Cal_Chl_CaCl2 = input$mashCalciumChloride,
                                  pH_UP_Epsom_Salt_MgSO4 = input$mashEpsomSalt,
                                  pH_DOWN_Slaked_Lime_CaOH2 = input$mashSlakedLime,
                                  pH_DOWN_Baking_Soda_NaHCO3 = input$mashBakingSoda,
                                  pH_DOWN_Chalk_CaCO3 = input$mashChalk,
                                  stringsAsFactors = F)
        })
        
        #Fermentables Table
        fermentablesData <- reactive({
          Fermentables <- data.frame(Recipe = rep(input$recipe,5),
                                     Ingredient = c(input$Ingredients1,input$Ingredients2,input$Ingredients3,input$Ingredients4,input$Ingredients5),
                                     Weight_Lbs = c(Lbs1(),Lbs2(),Lbs3(),Lbs4(),Lbs5()),
                                     Percent_Of_Total = c(input$IngredientPercent1,input$IngredientPercent2,input$IngredientPercent3,input$IngredientPercent4,input$IngredientPercent5),
                                     stringsAsFactors = F)
        })
        
        #Fermentation Table...make graph...do later because it is hard
        fermentationData <- reactive({
          Fermentation <- data.frame(Recipe = input$recipe,
                                     Days1 = input$days1,Temp1 = input$fermentationFirstTemp,
                                     Days2 = input$days2,Temp2 = input$fermentationSecondTemp,
                                     Days3 = input$days3,Temp3 = input$fermentationThirdTemp,
                                     Days4 = input$days4,Temp4 = input$fermentationFourthTemp,
                                     Days5 = input$days5,Temp5 = input$fermentationFifthTemp,
                                     stringsAsFactors = F)
        })
        
        #Hops Table
        hopsData <- reactive({
          Hops <- data.frame(Recipe = rep(input$recipe,5),
                             Name = c(input$Hops1,input$Hops2,input$Hops3,input$Hops4,input$Hops5),
                             Weight_Oz = c(input$Weight1,input$Weight2,input$Weight3,input$Weight4,input$Weight5),
                             Boil_Time_Min = c(input$BoilTime1,input$BoilTime2,input$BoilTime3,input$BoilTime4,input$BoilTime5),
                             Alpha_Acid_Content = c(input$AlphaAcid1,input$AlphaAcid2,input$AlphaAcid3,input$AlphaAcid4,input$AlphaAcid5),
                             Utilization = c(hopsUtilization1(),hopsUtilization2(),hopsUtilization3(),hopsUtilization4(),hopsUtilization5()),
                             IBU = c(IBU1(),IBU2(),IBU3(),IBU4(),IBU5()),
                             stringsAsFactors = F)
        })
        
        #Mash Tables...do we need a table for each mash type
        #...or one table where the most complicated mash with the most columns, dictates the number
        #of columns. Then either everything is filled in or we pad with NULLs.
        mashData <- reactive({
          Mash <- data.frame(Recipe = input$recipe,
                             Init_Grain_Temp = input$mashGrainTemp,
                             Infusion_Temp = Tw(),
                             Sacc_Rest_Temp = input$mashSaccRestTemp,
                             Mash_Duration = input$mashDuration,
                             Mash_Volume_Gal = mashVol(),
                             Mash_Thickness = input$mashThickness,
                             Mash_Out_Vol = Wa(),
                             stringsAsFactors = F)
        })
        #Not Correct
        systemData <- reactive({
          System <- data.frame(Recipe = input$recipe,
                               Batch_Size = input$batchSize,
                               Boil_Time = input$boilTime,
                               Evap_Rate = input$evap,
                               Shrinkage = input$shrink,
                               Efficiency = input$sysEfficiency,
                               Boil_Kettle_Dead_Space_Gal = input$kettleDeadSpace,
                               Lauter_Tun_Dead_Space_Gal = input$lauterTunDeadSpace,
                               Mash_Tun_Dead_Space_Gal = input$mashTunDeadSpace,
                               Fermentation_Tank_Loss_Gal = input$fermentationTankLoss,
                               stringsAsFactors = F)
        })
        
        yeastData <- reactive({
          Yeast <- data.frame(Recipe = input$recipe,
                              Name = input$Yeast,
                              Attenuation = input$attenuation,
                              ABV = ABV(),
                              Init_Cells = input$startYeastCells,
                              Needed_Cells = cellsNeeded(),
                              Liters_for_Starter = litersNeeded(),
                              stringsAsFactors = F)
        })
        
        observeEvent(input$submit, {
          saveData(chemistryData(), table = "Chemistry")
          saveData(fermentablesData(), "Fermentables")
          saveData(fermentationData(), "Fermentation")
          saveData(hopsData(), "Hops")
          saveData(mashData(), "Mash")
          saveData(systemData(), "System")
          saveData(yeastData(), "Yeast")
                
        })

    #Predicted:
    output$reportPredictedOG <- renderUI({numericInput(inputId = "reportPredictedOG", label = "OG:", value = OG())})
    output$reportPredictedFG <- renderUI({numericInput(inputId = "reportPredictedFG", label = "FG:", value = FG())})
    output$reportPredictedABV <- renderUI({numericInput(inputId = "reportPredictedABV", label = "ABV:", value = ABV())})
    output$reportPredictedIBU <- renderUI({numericInput(inputId = "reportPredictedIBU", label = "IBU:", value = Total_IBU())})
    output$reportPredictedSRM <- renderUI({numericInput(inputId = "reportPredictedSRM", label = "SRM:", value = 0)})
    
    #Actual:
    output$reportActualOG <- renderUI({numericInput(inputId = "reportActualOG", label = "OG:", value = 0)})
    output$reportActualFG <- renderUI({numericInput(inputId = "reportActualFG", label = "FG:", value = 0)})
    output$reportActualABV <- renderUI({numericInput(inputId = "reportActualABV", label = "ABV:", value = 0)})
    
    #Fermentables:
    output$reportIngredient1 <- renderUI({textInput(inputId = "reportIngredient1", label = "Ing1:", value = input$Ingredients1)})
    output$reportIngredient2 <- renderUI({textInput(inputId = "reportIngredient2", label = "Ing2:", value = input$Ingredients2)})
    output$reportIngredient3 <- renderUI({textInput(inputId = "reportIngredient3", label = "Ing3:", value = input$Ingredients3)})
    output$reportIngredient4 <- renderUI({textInput(inputId = "reportIngredient4", label = "Ing4:", value = input$Ingredients4)})
    output$reportIngredient5 <- renderUI({textInput(inputId = "reportIngredient5", label = "Ing5:", value = input$Ingredients5)})
    
    output$reportIngWeight1 <- renderUI({numericInput(inputId = "reportIngWeight1", label = "Weight:", value = Lbs1())})
    output$reportIngWeight2 <- renderUI({numericInput(inputId = "reportIngWeight2", label = "Weight:", value = Lbs2())})
    output$reportIngWeight3 <- renderUI({numericInput(inputId = "reportIngWeight3", label = "Weight:", value = Lbs3())})
    output$reportIngWeight4 <- renderUI({numericInput(inputId = "reportIngWeight4", label = "Weight:", value = Lbs4())})
    output$reportIngWeight5 <- renderUI({numericInput(inputId = "reportIngWeight5", label = "Weight:", value = Lbs5())})
    
    #Yeast:
    output$reportYeastName <- renderUI({textInput(inputId = "reportYeastName", label = "Name:", value = input$Yeast)})
    output$reportYeastAttenuation <- renderUI({numericInput(inputId = "reportYeastAttenuation", label = "Attn:", value = attenuation())})
    output$reportStarter <- renderUI({numericInput(inputId = "reportStarter", label = "Liters for Starter:", value = litersNeeded())})
    
    #Mash:
    output$reportsStepMashPlot <- renderPlot({stepMashPlot()}) # from step mash
    
    output$reportSaccRestTemp <- renderUI({textInput(inputId = "reportSaccRestTemp", label = "Sacc. Rest Temp:", value = input$mashSaccRestTemp)})
    output$reportInfTemp <- renderUI({textInput(inputId = "reportInfTemp", label = "Infusion Temp:", value = Tw())})
    output$reportSaccRestDuration <- renderUI({textInput(inputId = "reportSaccRestDuration", label = "Sacc. Rest Duration:", value = input$mashDuration)})
    output$reportMashVol <- renderUI({textInput(inputId = "reportMashVol", label = "Mash Vol:", value = mashVol())})
    output$reportMashOutVol <- renderUI({textInput(inputId = "reportMashOutVol", label = "Mash Out Vol:", value = Wa())})
    
    #Hops:
    output$reportHop1 <- renderUI({textInput(inputId = "reportHop1", label = "Hop:", value = input$Hops1)})
    output$reportHop2 <- renderUI({textInput(inputId = "reportHop2", label = "Hop:", value = input$Hops2)})
    output$reportHop3 <- renderUI({textInput(inputId = "reportHop3", label = "Hop:", value = input$Hops3)})
    output$reportHop4 <- renderUI({textInput(inputId = "reportHop4", label = "Hop:", value = input$Hops4)})
    output$reportHop5 <- renderUI({textInput(inputId = "reportHop5", label = "Hop:", value = input$Hops5)})
    
    output$reportHopWeight1 <- renderUI({numericInput(inputId = "reportHopWeight1", label = "Weight:", value = input$Weight1)})
    output$reportHopWeight2 <- renderUI({numericInput(inputId = "reportHopWeight2", label = "Weight:", value = input$Weight2)})
    output$reportHopWeight3 <- renderUI({numericInput(inputId = "reportHopWeight3", label = "Weight:", value = input$Weight3)})
    output$reportHopWeight4 <- renderUI({numericInput(inputId = "reportHopWeight4", label = "Weight:", value = input$Weight4)})
    output$reportHopWeight5 <- renderUI({numericInput(inputId = "reportHopWeight5", label = "Weight:", value = input$Weight5)})
    
    output$reportHopBoilTime1 <- renderUI({numericInput(inputId = "reportHopBoilTime1", label = "Boil Time:", value = input$BoilTime1)})
    output$reportHopBoilTime2 <- renderUI({numericInput(inputId = "reportHopBoilTime2", label = "Boil Time:", value = input$BoilTime2)})
    output$reportHopBoilTime3 <- renderUI({numericInput(inputId = "reportHopBoilTime3", label = "Boil Time:", value = input$BoilTime3)})
    output$reportHopBoilTime4 <- renderUI({numericInput(inputId = "reportHopBoilTime4", label = "Boil Time:", value = input$BoilTime4)})
    output$reportHopBoilTime5 <- renderUI({numericInput(inputId = "reportHopBoilTime5", label = "Boil Time:", value = input$BoilTime5)})
    
    #Fermentation:
    output$reportsFermentationPlot <- renderPlot({fermentationPlot()}) # from fermentation
    
    
    
}



