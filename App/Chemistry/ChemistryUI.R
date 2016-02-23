# Chemistry UI

chemistryUI <- function(){
        tabPanel("Chemistry",
                fluidRow(
                        h4("Step1: Initial Ion Concentrations (ppm or mg/L)"),
                        column(width = 2,
                               numericInput(inputId = "Ca",
                                            label = "Ca",
                                            value =  4)
                        ),
                        column(width = 2,
                               numericInput(inputId = "Mg",
                                            label = "Mg",
                                            value =  1)
                        ),
                        column(width = 2,
                               numericInput(inputId = "Na",
                                            label = "Na",
                                            value =  32)
                        ),
                        column(width = 2,
                               numericInput(inputId = "Cl",
                                            label = "Cl",
                                            value =  27)
                        ),
                        column(width = 2,
                               numericInput(inputId = "SO4",
                                            label = "SO4",
                                            value =  6)
                        ),
                        column(width = 2,
                               numericInput(inputId = "HCO3_CaCO3",
                                            label = "HCO3 or CaCO3",
                                            value =  40)
                        )
                ),
                fluidRow(
                        column(width = 2,
#                                strong("Mash Volume (Gal):"),
#                                verbatimTextOutput(outputId = "chemistryMashVol")
                               uiOutput(outputId = "chemistryMashVol")
                               ),
                        column(width = 2,
#                                strong("Sparge Volume (Gal):"),
#                                verbatimTextOutput(outputId = "chemistrySpargeVol")
                               uiOutput(outputId = "chemistrySpargeVol")
                               )
                ),
                fluidRow(
                        column(width = 2,
                               numericInput(inputId = "mashPercentDistilled",label = "% Distilled",value = 0)
                        ),
                        column(width = 2,
                               numericInput(inputId = "spargePercentDistilled",label = "% Distilled",value = 0)
                               
                        )
                ),
                h4("Step2: Grain Info"),
                fluidRow(
                        column(width = 5,
                                tableOutput(outputId = "grainInfo")
                        ),
                        column(width = 1,
                               HTML("<br>"),

                               "%",
                               HTML("<br>"),
                               HTML("<br>"),
                               HTML("<br>"),
                               "oz"
                        ),
                        column(width = 2,
                                numericInput(inputId = "acidulatedMaltPercent",label = "Acidulated Malt",value = 2),
                                numericInput(inputId = "acidulatedMaltOz",label = NULL,value = 0)
                        ),
                        column(width = 1,
                               HTML("<br>"),
                               
                               "%",
                               HTML("<br>"),
                               HTML("<br>"),
                               HTML("<br>"),
                               "ml"
                        ),
                        column(width = 2,
                               numericInput(inputId = "lacticAcidPercent",label = "Lactic Acid",value = 88),
                               numericInput(inputId = "lacticAcidml",label = NULL,value = 0)
                        )
                ),
                fluidRow(
                        h4("Step3: View Mash pH"),
                        column(width = 3,
                               strong("Estimated pH"),
                               verbatimTextOutput(outputId = "pH")
                        ),
                        column(width = 3,
                               strong("Effective Alkalinty"),
                               verbatimTextOutput(outputId = "effAlkalinity")
                        ),
                        column(width = 3,
                               strong("Residual Alkalinty"),
                               verbatimTextOutput(outputId = "resAlkalinity")
                        ),
                        column(width = 3,
                               strong("Desired Mash pH"),
                               verbatimTextOutput(outputId = "pHSuggestion")
                        )
                        
                ),
                h4("Step4(a): Adjust Mash pH Down (if needed)"),
                wellPanel(
                        fluidRow(
                                column(width = 3,
                                       #HTML("<br>"),
                                       h4("Mash Additions"),
                                       h4("(grams)")
                                ),
                                column(width = 3,
                                       numericInput(inputId = "mashGypsum",
                                                    label = "Gypsum CaSO4",
                                                    value =  5)
                                ),
                                column(width = 3,
                                       numericInput(inputId = "mashCalciumChloride",
                                                    label = "Cal.Chl. CaCl2",
                                                    value =  5)
                                ),
                                column(width = 3,
                                       numericInput(inputId = "mashEpsomSalt",
                                                    label = "Epsom Salt MgSO4",
                                                    value =  5)
                                )
                        ),
                        fluidRow(
                                column(width = 3,
                                       #HTML("<br>"),
                                       h4("Adjusting Sparge Water?")
                                ),
                                column(width = 3,
                                       HTML("<br>"),
                                       checkboxInput(inputId = "checkGypsum", label = NULL, value = FALSE)
                                ),
                                column(width = 3,
                                       HTML("<br>"),
                                       checkboxInput(inputId = "checkCalciumChloride", label = NULL, value = FALSE)
                                ),
                                column(width = 3,
                                       HTML("<br>"),
                                       checkboxInput(inputId = "checkEpsomSalt", label = NULL, value = FALSE)
                                )
                        ),
                        fluidRow(
                                column(width = 3,
                                       #HTML("<br>"),
                                       h4("Sparge Additions"),
                                       h4("(grams)")
                                ),
                                column(width = 3,
                                       strong("Gypsum CaSO4"),
                                       verbatimTextOutput(outputId = "spargeGypsum")
                                ),
                                column(width = 3,
                                       strong("Cal.Chl. CaCl2"),
                                       verbatimTextOutput(outputId = "spargeCalciumChloride")
                                ),
                                column(width = 3,
                                       strong("Epsom Salt MgSO4"),
                                       verbatimTextOutput(outputId = "spargeEpsomSalt")
                                )
                        )
                ), #End of wellPanel()
                h4("Step4(b): Adjust Mash pH Up (if needed)"),
                wellPanel(
                        fluidRow(
                                column(width = 3,
                                       #HTML("<br>"),
                                       h4("Mash Additions"),
                                       h4("(grams")
                                ),
                                column(width = 3,
                                       numericInput(inputId = "mashSlakedLime",
                                                    label = "Slaked Lime Ca(OH)2",
                                                    value =  0)
                                ),
                                column(width = 3,
                                       numericInput(inputId = "mashBakingSoda",
                                                    label = "Baking Soda NaHCO3",
                                                    value =  0)
                                ),
                                column(width = 3,
                                       numericInput(inputId = "mashChalk",
                                                    label = "Chalk CaCO3",
                                                    value =  0)
                                )
                        ),
                        fluidRow(
                                column(width = 3,
                                       HTML("<br>"),
                                       h4("Adjusting Sparge Water? ")
                                ),
                                column(width = 3,
                                       HTML("<br>"),
                                       checkboxInput(inputId = "checkSlakedLime", label = NULL, value = FALSE)
                                ),
                                column(width = 3,
                                       HTML("<br>"),
                                       checkboxInput(inputId = "checkBakingSoda", label = NULL, value = FALSE)
                                ),
                                column(width = 3,
                                       HTML("<br>"),
                                       checkboxInput(inputId = "checkChalk", label = NULL, value = FALSE)
                                )
                        ),
                        fluidRow(
                                column(width = 3,
                                       #HTML("<br>"),
                                       h4("Sparge Additions "),
                                       h4("(grams)")
                                ),
                                column(width = 3,
                                       strong("Gypsum CaSO4"),
                                       verbatimTextOutput(outputId = "spargeSlakedLime")
                                ),
                                column(width = 3,
                                       strong("Cal.Chl. CaCl2"),
                                       verbatimTextOutput(outputId = "spargeBakingSoda")
                                ),
                                column(width = 3,
                                       strong("Epsom Salt MgSO4"),
                                       verbatimTextOutput(outputId = "spargeChalk")
                                )
                        )
                ), #End of wellPanel()
                h4("Step5: View Resulting Water Profile"),
                wellPanel(
                        fluidRow(
                                column(width = 3,
                                       #HTML("<br>"),
                                       h4("Mash Profile "),
                                       h4("(ppm)")
                                ),
                                column(width = 1,
                                       strong("Ca"),
                                       verbatimTextOutput(outputId = "mashCalcium")
                                ),
                                column(width = 1,
                                       strong("Mg"),
                                       verbatimTextOutput(outputId = "mashMagnesium")
                                ),
                                column(width = 1,
                                       strong("Na"),
                                       verbatimTextOutput(outputId = "mashSodium")
                                ),
                                column(width = 1,
                                       strong("Cl"),
                                       verbatimTextOutput(outputId = "mashChloride")
                                ),
                                column(width = 1,
                                       strong("SO4"),
                                       verbatimTextOutput(outputId = "mashSulfate")
                                ),
                                column(width = 1,
                                       strong("Cl/SO4"),
                                       verbatimTextOutput(outputId = "mashChlorideSulfate")
                                )
                        ),
                        fluidRow(
                                column(width = 3,
                                       #HTML("<br>"),
                                       h4("Mash + Sparge Profile"),
                                       h4("(ppm)")
                                ),
                                column(width = 1,
                                       strong("Ca"),
                                       verbatimTextOutput(outputId = "M_SCalcium")
                                ),
                                column(width = 1,
                                       strong("Mg"),
                                       verbatimTextOutput(outputId = "M_SMagnesium")
                                ),
                                column(width = 1,
                                       strong("Na"),
                                       verbatimTextOutput(outputId = "M_SSodium")
                                ),
                                column(width = 1,
                                       strong("Cl"),
                                       verbatimTextOutput(outputId = "M_SChloride")
                                ),
                                column(width = 1,
                                       strong("SO4"),
                                       verbatimTextOutput(outputId = "M_SSulfate")
                                ),
                                column(width = 1,
                                       strong("Cl/SO4"),
                                       verbatimTextOutput(outputId = "M_SChlorideSulfate")
                                )
                        ),
                        fluidRow(
                                column(width = 3,
                                       HTML("<br>"),
                                       h4("Recommended Ranges"),
                                       h4("(ppm)")
                                ),
                                column(width = 1,
                                       strong("Ca"),
                                       verbatimTextOutput(outputId = "recommendedCalcium")
                                ),
                                column(width = 1,
                                       strong("Mg"),
                                       verbatimTextOutput(outputId = "recommendedMagnesium")
                                ),
                                column(width = 1,
                                       strong("Na"),
                                       verbatimTextOutput(outputId = "recommendedSodium")
                                ),
                                column(width = 1,
                                       strong("Cl"),
                                       verbatimTextOutput(outputId = "recommendedChloride")
                                ),
                                column(width = 1,
                                       strong("SO4"),
                                       verbatimTextOutput(outputId = "recommendedSulfate")
                                ),
                                column(width = 1,
                                       strong("Cl/SO4"),
                                       verbatimTextOutput(outputId = "recommendedChlorideSulfate")
                                )
                        ),
                        fluidRow(
                                "*Cl/SO4",
                                verbatimTextOutput(outputId = "Chl_SO4_Ratio_Message")
                        )
                ) #End of wellPanel()
        )
}