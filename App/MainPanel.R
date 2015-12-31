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
                                value = 0.0),
                   numericInput(inputId = "lauterTunDeadSpace",
                                label = "Lauter Tun Dead Space (Gal):",
                                value = 0.25),
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
     )
    
}