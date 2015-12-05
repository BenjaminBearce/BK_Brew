library(shiny)

# Load Data --------------------
library(shiny, quietly = TRUE, warn.conflicts = FALSE)
library(RODBC, quietly = TRUE, warn.conflicts = FALSE)
library(sqldf, quietly = TRUE, warn.conflicts = FALSE)
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(stringr, quietly = TRUE, warn.conflicts = FALSE)


setwd("~/Github/BK_Brew/Database") #Change directory to Brewing directory
db <- dbConnect(SQLite(), dbname="Ingredients.sqlite")
Grains <- dbReadTable(db, "Grains")
Extracts <- dbReadTable(db, "Extracts")
Adjuncts <- dbReadTable(db, "Adjuncts")
Hops <- dbReadTable(db, "Hops")
Spices <- dbReadTable(db, "Spices")
Yeast <- dbReadTable(db, "Yeast")
Styles <- dbReadTable(db, "Styles")
setwd("~/Github/BK_Brew/Shiny_Brew_Practice") #Change directory to Shiny_Brew_Practice
# Load UI Components --------------------
source("FermentablesUI.R", local = TRUE)


# UI --------------------
ui <- fluidPage(
    titlePanel("BK Brewery", windowTitle = "BK Brewery"),
# Sidebar Layout --------------------
    sidebarLayout(
# Sidebar Panel --------------------
        sidebarPanel(
            h4("What Beer?"),
            textInput(inputId = "Brewer", label = "Brewer",value = "Big Kitchen"),
            textInput(inputId = "RecipeName", label = "Recipe Name",value = ""),
            selectInput(inputId = "Style", label = "BJCP Geneneral Beer Style",choices = unique(Styles$Styles)),
            textInput(inputId = "DateBrewed", label = "Date Brewed",value = Sys.time()),
            width = 2
        ),
# Main Panel --------------------
        mainPanel(
            h4("System Specific Constants"),
                fluidRow(
                    column(width = 5,
                           numericInput(inputId = "batchSize",
                                        label = "Batch Size (Gal):",
                                        value = 5.5),
                           numericInput(inputId = "boilTime",
                                        label = "Boil Time (Min):",
                                        value = 60),
                           numericInput(inputId = "evap",
                                        label = "Evaporation (%/hr)",
                                        value = 5),
                           numericInput(inputId = "shrink",
                                        label = "Shrinkage From Cooling (%)",
                                        value = 4),
                           numericInput(inputId = "sysEfficiency",
                                        label = "Brew House Efficiency (%)",
                                        value = 70),
                           numericInput(inputId = "scaleRecipe",
                                        label = "Scale Current Recipe (%)",
                                        value = 100)
                    ),
                    column(width = 5, offset = 1,
                           numericInput(inputId = "weightMashTun",
                                        label = "Weight of Mash Tun (lbs):",
                                        value = 7.5),
                           numericInput(inputId = "thermalMassMashTun",
                                        label = "Thermal Mash of Mash Tun (btu/(lb*F)):",
                                        value = 0.38),
                           numericInput(inputId = "kettleDeadSpace",
                                        label = "Boil Kettle Dead Space (Gal):",
                                        value = 0.5),
                           numericInput(inputId = "lauterTunDeadSpace",
                                        label = "Lauter Tun Dead Space (Gal):",
                                        value = 0.5),
                           numericInput(inputId = "mashTunDeadSpace",
                                        label = "Mash Tun Dead Space (Gal):",
                                        value = 0),
                           numericInput(inputId = "fermentationTankLoss",
                                        label = "Fermentation Tank Loss (Gal):",
                                        value = 0)
                    )
                ),
            width = 10
        )
        
    ),
# Tabset Panel --------------------

    tabsetPanel(type = "tabs",
# Fermentables --------------------

        X(),
# Yeast --------------------
        tabPanel("Yeast",
            selectInput(inputId = "Yeast",
                        label = "Yeast",
                        choices =  Yeast$YeastStrain),
            textOutput(outputId = "Yeast")
        ),
# Hops --------------------
        tabPanel("Hops", 
                 selectInput(inputId = "Hops",
                             label = "Hops",
                             choices =  Hops$Hops),
                 textOutput(outputId = "Hops")
        ),
# Mash --------------------
        tabPanel("Mash", 
            #Plot Temp Mash Schedule
            plotOutput("MashSchedule")
        ),
# Chemistry --------------------
        tabPanel("Chemistry", "Chemistry"),
# Water --------------------
        tabPanel("Water", "Water"),
# Fermentation --------------------
        tabPanel("Fermentation", "Fermentation")
    )

)
# Server --------------------
server <- function(input, output){
# Fermentables Output --------------------
# Fermentables1 --------------------

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
    
    
# Yeast Output --------------------
    output$Yeast <- renderText({
        input$Yeast
    })
# Hops Output --------------------
    output$Hops <- renderText({
        input$Hops
    })
# Mash Schedule Output --------------------
output$MashSchedule <- renderPlot({
    plot(x = seq(1,5, length.out = 35),
         y = c(rep(120,5),130,rep(140,10),145,150,rep(155,10),160,170,rep(170,5)))
    
})
# Chemistry Output --------------------
# Water Output --------------------
# Fermentation Output --------------------
}

# Build App --------------------
shinyApp(ui = ui, server = server)








