# Load Data --------------------
library(shiny, quietly = TRUE, warn.conflicts = FALSE)
library(RODBC, quietly = TRUE, warn.conflicts = FALSE)
library(sqldf, quietly = TRUE, warn.conflicts = FALSE)
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(tidyr, quietly = TRUE, warn.conflicts = FALSE)
library(stringr, quietly = TRUE, warn.conflicts = FALSE)
library(ggplot2, quietly = TRUE, warn.conflicts = FALSE)
library(shinyBS, quietly = TRUE, warn.conflicts = FALSE)


setwd("Database") #Change directory to Brewing directory
db <- dbConnect(SQLite(), dbname="Ingredients.sqlite")
Grains <- dbReadTable(db, "Grains")
Grains <- Grains[order(Grains$Ingredients),]
Extracts <- dbReadTable(db, "Extracts")
Adjuncts <- dbReadTable(db, "Adjuncts")
Grists <- rbind(Grains,Extracts,Adjuncts) %>% arrange(Ingredients)
Hops <- dbReadTable(db, "Hops")
Spices <- dbReadTable(db, "Spices")
Yeast <- dbReadTable(db, "Yeast")
Styles <- dbReadTable(db, "Styles")

db <-  dbConnect(SQLite(), dbname="BKBrewHouse.sqlite")
GravityVersusTemp <-  dbReadTable(db, "GravityCorrectionChart")
closeAllConnections()

setwd("../App") #Change directory to App
# Load UI Components --------------------
source("SidePanel.R", local = TRUE)
source("MainPanelUI.R", local = TRUE)
source("Fermentables/FermentablesUI.R", local = TRUE)
source("Yeast/YeastUI.R", local = TRUE)
source("Hops/HopsUI.R", local = TRUE)
#mash
source("Mash/MashUI.R", local = TRUE)
source("Mash/StepMash/StepMashUI.R", local = TRUE)
source("Mash/SingleDecoction/SingleDecoctionUI.R", local = TRUE)
source("Mash/DoubleDecoction/DoubleDecoctionUI.R", local = TRUE)
source("Mash/EnhancedDoubleDecoction/EnhancedDoubleDecoctionUI.R", local = TRUE)
source("Mash/HochkuraDoubleDecoction/HochkuraDoubleDecoctionUI.R", local = TRUE)
source("Chemistry/ChemistryUI.R", local = TRUE)
source("Water/WaterUI.R", local = TRUE)
source("Fermentation/FermentationUI.R", local = TRUE)
source("Reports/ReportsUI.R", local = TRUE)

# Load Server Components --------------------
source("MainPanelServer.R", local = TRUE)
source("Fermentables/FermentablesServer.R", local = TRUE)
source("Yeast/YeastServer.R", local = TRUE)
source("Hops/HopsServer.R", local = TRUE)
#mash
source("Mash/MashServer.R", local = TRUE)
source("Mash/StepMash/StepMashServer.R", local = TRUE)
source("Mash/SingleDecoction/SingleDecoctionServer.R", local = TRUE)
source("Mash/DoubleDecoction/DoubleDecoctionServer.R", local = TRUE)
source("Mash/EnhancedDoubleDecoction/EnhancedDoubleDecoctionServer.R", local = TRUE)
source("Mash/HochkuraDoubleDecoction/HochkuraDoubleDecoctionServer.R", local = TRUE)
source("Chemistry/ChemistryServer.R", local = TRUE)
source("Water/WaterServer.R", local = TRUE)
source("Fermentation/FermentationServer.R", local = TRUE)
source("Reports/ReportsServer.R", local = TRUE)

# UI --------------------
ui <- fluidPage(
        # Header --------------------
        titlePanel("BK Brewery", windowTitle = "BK Brewery"),
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
                    fermentationUI(),
                    # Reports --------------------
                    reportsUI()
        ),
        wellPanel(style = "background-color: #0EAE20",
                  sidebarLayout(
                          
                          # Sidebar Panel --------------------
                          sidePanel(),
                          # Main Panel --------------------
                          panelMain()
                          
                  )
        ),
        imageOutput("image")
        
        # Sidebar Layout --------------------

)
# Server --------------------
server <- function(input, output, session){
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
        fermentablesServer(input, output, session)
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
        # Reports Output --------------------
        reportsServer(input, output)
}

# Build App --------------------
#runApp(shinyApp(ui = ui, server = server), launch.browser = TRUE)
shinyApp(ui = ui, server = server)








