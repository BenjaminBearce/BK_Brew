library(shiny, quietly = TRUE, warn.conflicts = FALSE)
library(RODBC, quietly = TRUE, warn.conflicts = FALSE)
library(sqldf, quietly = TRUE, warn.conflicts = FALSE)

#-------------------- Initialize Data ----------------------#
setwd("~/Github/BK_Brew/Database") #Change directory to Brewing directory
db <- dbConnect(SQLite(), dbname="Ingredients.sqlite")
Grains <- dbReadTable(db, "Grains")
Extracts <- dbReadTable(db, "Extracts")
Adjuncts <- dbReadTable(db, "Adjuncts")


#----------------------- Build UI --------------------------#
ui <- fluidPage(
    titlePanel("Fermentables", windowTitle = "Fermentables"),
    flowLayout(selectInput(inputId = "Grains",
                           label = "Grains",
                           choices =  Grains$Ingredients),
               
               selectInput(inputId = "Extracts",
                           label = "Extracts",
                           choices =  Extracts$Ingredients),
               
               selectInput(inputId = "Adjuncts",
                           label = "Adjuncts",
                           choices =  Adjuncts$Ingredients)
    ),
    
    flowLayout(textOutput(outputId = "Grains"),
               textOutput(outputId = "Extracts"),
               textOutput(outputId = "Adjuncts"))
    
    
    
)

server <- function(input, output){
    
    output$Grains <- renderText({
        input$Grains
    })
    output$Extracts <- renderText({
        input$Extracts
    })
    output$Adjuncts <- renderText({
        input$Adjuncts
    })
    
}

shinyApp(ui = ui, server = server)