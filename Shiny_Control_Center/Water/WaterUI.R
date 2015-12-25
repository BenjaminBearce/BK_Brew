# Water UI

waterUI <- function(){
        tabPanel(title = "Water",
                 sidebarLayout(
                         sidebarPanel(style = "background-color: #BED4C9", width = 2,
                                      strong("Batch Size (Gal):"),
                                      wellPanel(textOutput(outputId = "waterBatchSize")),
                                      strong("Grain Bill (Lbs):"),
                                      wellPanel(textOutput(outputId = "waterTotalGrain")),
                                      strong("Equip. Losses (Gal):"),
                                      wellPanel(textOutput(outputId = "waterEquipLoss")),
                                      numericInput(inputId = "mashThickness",
                                                   label = "Mash Thickness (Qts/Lb):",
                                                   value = 1.25),
                                      numericInput(inputId = "grainAbsorptionFactor",
                                                   label = "Grain Absorption Factor (Gal/Lb):",
                                                   value = .125)
                                      
                         ),
                         mainPanel(
                                   plotOutput(outputId = "waterGraph"))

                 )
        )
}