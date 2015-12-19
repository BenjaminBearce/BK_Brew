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
setwd("~/Github/BK_Brew/Shiny_Control_Center") #Change directory to Shiny_Control_Center
# Load UI Components --------------------
source("~/Github/BK_Brew/Shiny_Control_Center/SidePanel.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/MainPanel.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Fermentables/FermentablesUI.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Yeast/YeastUI.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Hops/HopsUI.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Mash/MashUI.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Chemistry/ChemistryUI.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Water/WaterUI.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Fermentation/FermentationUI.R", local = TRUE)
# Load Server Components --------------------
source("~/Github/BK_Brew/Shiny_Control_Center/Fermentables/FermentablesServer.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Yeast/YeastServer.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Hops/HopsServer.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Mash/MashServer.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Chemistry/ChemistryServer.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Water/WaterServer.R", local = TRUE)
source("~/Github/BK_Brew/Shiny_Control_Center/Fermentation/FermentationServer.R", local = TRUE)

# UI --------------------
ui <- fluidPage(
    titlePanel("BK Brewery", windowTitle = "BK Brewery"),
# Sidebar Layout --------------------
    wellPanel(style = "background-color: #0EAE20",
            sidebarLayout(
                
# Sidebar Panel --------------------
                sidePanel(),
# Main Panel --------------------
                panelMain()
                
            )
    ),
# Tabset Panel --------------------

    tabsetPanel(type = "tabs",
# Fermentables --------------------
        fermentablesUI(),
# Yeast --------------------
        yeastUI(),
# Hops --------------------
        hopsUI(),
# Mash --------------------
        mashUI(),
# Chemistry --------------------
        chemistryUI(),
# Water --------------------
        waterUI(),
# Fermentation --------------------
        fermentationUI()
    )

)
# Server --------------------
server <- function(input, output){
# Fermentables Output --------------------
        fermentablesServer(input, output)
# Yeast Output --------------------
        yeastServer(input, output)
# Hops Output --------------------
        hopsServer(input, output)
# Mash Schedule Output --------------------
        mashServer(input, output)
# Chemistry Output --------------------
        chemistryServer(input, output)
# Water Output --------------------
        waterServer(input, output)
# Fermentation Output --------------------
        fermentationServer(input, output)
}

# Build App --------------------
shinyApp(ui = ui, server = server)








