# Main Panel

panelMain <- function(){
    
    mainPanel(
        wellPanel(style = "background-color: #BED4C9",
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
                                value = 73.5),
                   numericInput(inputId = "scaleRecipe",
                                label = "Scale Current Recipe (%)",
                                value = 100)
            ),
            column(width = 5, offset = 1,
                   numericInput(inputId = "kettleDeadSpace",
                                label = "Boil Kettle Dead Space (Gal):",
                                value = 0),
                   numericInput(inputId = "lauterTunDeadSpace",
                                label = "Lauter Tun Dead Space (Gal):",
                                value = 0.25),
                   numericInput(inputId = "mashTunDeadSpace",
                                label = "Mash Tun Dead Space (Gal):",
                                value = 0),
                   numericInput(inputId = "fermentationTankLoss",
                                label = "Fermentation Tank Loss (Gal):",
                                value = 0),
                   selectInput(inputId = "MashTunType",
                               label = "Mash Tun Type",
                               choices =  c("Kettle/Pot",
                                            "Cooler")),
                   uiOutput("MashTunExtras")
            )
        ),
        width = 10
        )
     )
    
}