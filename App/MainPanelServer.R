
# MainPanel Server

mainPanelServer <- function(input, output){
        
        output$MashTunExtras <- renderUI({
                if (input$MashTunType == "Cooler") {
                        fluidRow(
                                column(width=12,
                                       numericInput(inputId = "weightMashTun",
                                                    label = "Weight of Mash Tun (lbs):",
                                                    value = 7.5),
                                       numericInput(inputId = "thermalMassMashTun",
                                                    label = "Thermal Mash of Mash Tun (btu/(lb*F)):",
                                                    value = 0.38)
                                )
                        )
                }
        })
        
}