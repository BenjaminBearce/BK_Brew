# Water UI

waterUI <- function(){
        tabPanel(title = "Water",
                 sidebarLayout(
                         sidebarPanel(style = "background-color: #BED4C9",
                                      "side panel"
                         ),
                         mainPanel(style = "background-color: #BED4C9",
                                   "main panel")
#                  fluidRow(
#                          column(width = 2,
#                                 strong("Batch Size (Gal):"),
#                                 wellPanel(textOutput(outputId = "waterBatchSize"))
#                          ),
#                          column(width = 2,
#                                 strong("Grain Bill (Lbs):"),
#                                 wellPanel(textOutput(outputId = "waterTotalGrain"))
#                          ),
#                          column(width = 2,
#                                 strong("Equip. Losses (Gal):"),
#                                 wellPanel(textOutput(outputId = "waterEquipLoss"))
#                          ),
#                          column(width = 2,
#                                 numericInput(inputId = "mashThickness",
#                                              label = "Mash Thickness (Qts/Lb):",
#                                              value = 1.25)
#                          )
#                  )
                 )
        )
}