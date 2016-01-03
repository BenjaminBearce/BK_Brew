library(shiny)

# Load Data --------------------
library(shiny, quietly = TRUE, warn.conflicts = FALSE)
library(RODBC, quietly = TRUE, warn.conflicts = FALSE)
library(sqldf, quietly = TRUE, warn.conflicts = FALSE)
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(stringr, quietly = TRUE, warn.conflicts = FALSE)
library(ggplot2, quietly = TRUE, warn.conflicts = FALSE)


setwd("~/Github/BK_Brew/Database") #Change directory to Brewing directory
db <- dbConnect(SQLite(), dbname="Ingredients.sqlite")
Grains <- dbReadTable(db, "Grains")
Extracts <- dbReadTable(db, "Extracts")
Adjuncts <- dbReadTable(db, "Adjuncts")
Hops <- dbReadTable(db, "Hops")
Spices <- dbReadTable(db, "Spices")
Yeast <- dbReadTable(db, "Yeast")
Styles <- dbReadTable(db, "Styles")
setwd("~/Github/BK_Brew/App") #Change directory to App
# Load UI Components --------------------
source("~/Github/BK_Brew/App/SidePanel.R", local = TRUE)
source("~/Github/BK_Brew/App/MainPanelUI.R", local = TRUE)
source("~/Github/BK_Brew/App/Fermentables/FermentablesUI.R", local = TRUE)
source("~/Github/BK_Brew/App/Yeast/YeastUI.R", local = TRUE)
source("~/Github/BK_Brew/App/Hops/HopsUI.R", local = TRUE)
source("~/Github/BK_Brew/App/Mash/MashUI.R", local = TRUE)
source("~/Github/BK_Brew/App/Chemistry/ChemistryUI.R", local = TRUE)
source("~/Github/BK_Brew/App/Water/WaterUI.R", local = TRUE)
source("~/Github/BK_Brew/App/Fermentation/FermentationUI.R", local = TRUE)
# Load Server Components --------------------
source("~/Github/BK_Brew/App/MainPanelServer.R", local = TRUE)
source("~/Github/BK_Brew/App/Fermentables/FermentablesServer.R", local = TRUE)
source("~/Github/BK_Brew/App/Yeast/YeastServer.R", local = TRUE)
source("~/Github/BK_Brew/App/Hops/HopsServer.R", local = TRUE)
source("~/Github/BK_Brew/App/Mash/MashServer.R", local = TRUE)
source("~/Github/BK_Brew/App/Chemistry/ChemistryServer.R", local = TRUE)
source("~/Github/BK_Brew/App/Water/WaterServer.R", local = TRUE)
source("~/Github/BK_Brew/App/Fermentation/FermentationServer.R", local = TRUE)

# UI --------------------
ui <- fluidPage(
# Header --------------------
    titlePanel("BK Brewery", windowTitle = "BK Brewery"),
    imageOutput("image"),
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
# Header Image Output -------------------- 
        output$image <- renderImage({
                return(list(
                        src = "Brew.png",
                        contentType = "image/png",
                        alt = "Face",
                        width = 1545,
                        height = 400))
        },deleteFile = FALSE)
# Main Panel Server - --------------------
        mainPanelServer(input, output)
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








