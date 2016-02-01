calcLbs <- function(input,ing,ingPct){
        
        if (ing != " None") {

                lowerRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeLow)) - 1)*1000
                higherRange <- (as.numeric(subset(Styles, Styles == input$Style, select = OGRangeHigh)) - 1)*1000
                print(class(lowerRange));print(class(higherRange))
                OG <- mean(c(lowerRange,higherRange)) #/1000+1
                
                totalGravity <- OG*input$batchSize #OG*Gal
                
                grains <- Grists %>% 
                        filter(Ingredients == ing) %>% 
                        mutate(IngredientGravity = ingPct/100*totalGravity) %>%
                        mutate(lbsNeeded = IngredientGravity/((PPG-1)*1000*input$sysEfficiency/100)) %>%
                        select(lbsNeeded)
        } else {
                grains <- 0
        }
}

calcTotGrain <- function(input){

        grains1 <- calcLbs(input,input$Ingredients1,input$IngredientPercent1)
        grains2 <- calcLbs(input,input$Ingredients2,input$IngredientPercent2)
        grains3 <- calcLbs(input,input$Ingredients3,input$IngredientPercent3)
        grains4 <- calcLbs(input,input$Ingredients4,input$IngredientPercent4)
        grains5 <- calcLbs(input,input$Ingredients5,input$IngredientPercent5)
        
        lbs <- as.numeric(grains1+grains2+grains3+grains4+grains5)

}

# Fermentables Server

fermentablesServer <- function(input, output, session){
        DPcalc <- reactive({
                

                DPnum <- as.numeric((Grists %>% filter(Ingredients == input$Ingredients1) %>% mutate(DP1=DP*isGrain*grains1()) %>% select(DP1)) +
                                             (Grists %>% filter(Ingredients == input$Ingredients2) %>% mutate(DP2=DP*isGrain*grains2()) %>% select(DP2)) +
                                             (Grists %>% filter(Ingredients == input$Ingredients3) %>% mutate(DP3=DP*isGrain*grains3()) %>% select(DP3)) +
                                             (Grists %>% filter(Ingredients == input$Ingredients4) %>% mutate(DP4=DP*isGrain*grains4()) %>% select(DP4)) +
                                             (Grists %>% filter(Ingredients == input$Ingredients5) %>% mutate(DP5=DP*isGrain*grains5()) %>% select(DP5)))
                DPden <- as.numeric((Grists %>% filter(Ingredients == input$Ingredients1) %>% select(isGrain)*grains1()) +
                                             (Grists %>% filter(Ingredients == input$Ingredients2) %>% select(isGrain)*grains2()) +
                                             (Grists %>% filter(Ingredients == input$Ingredients3) %>% select(isGrain)*grains3()) +
                                             (Grists %>% filter(Ingredients == input$Ingredients4) %>% select(isGrain)*grains4()) +
                                             (Grists %>% filter(Ingredients == input$Ingredients5) %>% select(isGrain)*grains5()))

                
                DP <- DPnum/DPden
                
                sumIngPct <- input$IngredientPercent1+input$IngredientPercent2+input$IngredientPercent3+input$IngredientPercent4+input$IngredientPercent5
                
                if (input$DPcheck == "Advanced" & DPnum > 0 & DP < 35.0 & is.finite(DP) & sumIngPct == 100) {
                        createAlert(session,"DPalert","DPalert1",content="DP is below 35 Linter and needs to be higher, in order for full self conversion of the mash. Add more base malt.")
                } else if (input$DPcheck == "Advanced") {
                        closeAlert(session,"DPalert1")
                }
                
                if (is.finite(DP)) {
                        return(DP)
                } else {
                        return(0)
                }
                
        })
        
        output$DPcalcVal <- renderText({as.character(DPcalc())})
        
        output$DPcalc <- renderUI({
                if (input$DPcheck == "Advanced") {
                        fluidRow(column(width=12,strong("Diastatic Power [\u00B0L]"),verbatimTextOutput("DPcalcVal")))
                }
        })
        
        output$DPalert <- renderUI({
                if (input$DPcheck == "Advanced") {
                        fluidRow(column(width=12,strong(" "),bsAlert("DPalert")))
                }
        })
        
        grains1 <<- reactive({calcLbs(input,input$Ingredients1,input$IngredientPercent1)})
        grains2 <<- reactive({calcLbs(input,input$Ingredients2,input$IngredientPercent2)})
        grains3 <<- reactive({calcLbs(input,input$Ingredients3,input$IngredientPercent3)})
        grains4 <<- reactive({calcLbs(input,input$Ingredients4,input$IngredientPercent4)})
        grains5 <<- reactive({calcLbs(input,input$Ingredients5,input$IngredientPercent5)})
        totalGrain <<- reactive({calcTotGrain(input)})
        
        output$Lbs1 <- renderText({
                as.character(round(grains1(),2))
        })
        output$Lbs2 <- renderText({
                as.character(round(grains2(),2))
        })
        output$Lbs3 <- renderText({
                as.character(round(grains3(),2))
        })
        output$Lbs4 <- renderText({
                as.character(round(grains4(),2))
        })
        output$Lbs5 <- renderText({
                as.character(round(grains5(),2))

        })
        
        output$fermentablesTotalGrain <- renderText({
                round(totalGrain(),2)
        })
        
}
