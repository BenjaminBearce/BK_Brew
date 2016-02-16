# Chemistry UI

chemistryUI <- function(){
        tabPanel("Chemistry",
                fluidRow(
                        h4("Step1: Initial Ion Concentrations (ppm or mg/L)"),
                        column(width = 1,
                               numericInput(inputId = "Ca",
                                            label = "Ca",
                                            value =  4)
                        ),
                        column(width = 1,
                               numericInput(inputId = "Mg",
                                            label = "Mg",
                                            value =  1)
                        ),
                        column(width = 1,
                               numericInput(inputId = "Na",
                                            label = "Na",
                                            value =  32)
                        ),
                        column(width = 1,
                               numericInput(inputId = "Cl",
                                            label = "Cl",
                                            value =  27)
                        ),
                        column(width = 1,
                               numericInput(inputId = "SO4",
                                            label = "CaCO3",
                                            value =  6)
                        ),
                        column(width = 2,
                               numericInput(inputId = "HCO3_CaCO3",
                                            label = "HCO3 or CaCO3",
                                            value =  40)
                        )
                ),
                fluidRow(
                        h4("Step2: Grain Info"),
                        tableOutput(outputId = "grainInfo")
                ),
                fluidRow(
                        h4("Step3: View Mash pH"),
                        column(width = 2,
                               strong("Estimated Room Temp pH"),
                               verbatimTextOutput(outputId = "pH")
                        )
                ),
                fluidRow(
                        h4("Step4(a): Adjust Mash pH Down (if needed)")
                ),
                fluidRow(
                        h4("Step4(b): Adjust Mash pH Up (if needed)")
                ),
                fluidRow(
                        h4("Step5: View Resulting Water Profile")
                )
        )
}