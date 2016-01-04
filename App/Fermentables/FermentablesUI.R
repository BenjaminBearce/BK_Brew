# Fermentables UI

fermentablesUI <- function(){
        tabPanel("Fermentables",
                 HTML("<br>"),
                 fluidRow(
                         column(width = 4,
                                selectInput(inputId = "DPcheck",
                                            label = "Fermentables Difficulty",
                                            choices = c("Default","Advanced")),
                                bsTooltip("DPcheck","Advanced will alert user when Diastatic Power is too low for self conversion","top","hover focus")
                         ),
                         column(width = 4,
                                uiOutput("DPcalc")
                         ),
                         column(width = 4,
                                uiOutput("DPalert"))
                 ),
                 fluidRow(
                         column(width = 4,
                                selectInput(inputId = "Ingredients1",
                                            label = "Ingredients",
                                            choices =  c(Grains$Ingredients, Extracts$Ingredients, Adjuncts$Ingredients))
                         ),
                         column(width = 2,
                                numericInput(inputId = "IngredientPercent1",
                                             label = "Percent",
                                             value = 0)
                         ),
                         column(width = 2,
                                strong("Lbs"),
                                verbatimTextOutput(outputId = "OG1")
                         ),
                         column(width = 2,
                                strong("Total Grains (Lbs)"),
                                verbatimTextOutput(outputId = "fermentablesTotalGrain")
                         )
                         
                 ),
                 fluidRow(
                         column(width = 4,
                                selectInput(inputId = "Ingredients2",
                                            label = NULL,
                                            choices =  c(Grains$Ingredients, Extracts$Ingredients, Adjuncts$Ingredients))
                         ),
                         column(width = 2,
                                numericInput(inputId = "IngredientPercent2",
                                             label = NULL,
                                             value = 0)
                         ),
                         column(width = 2,
                                verbatimTextOutput(outputId = "OG2")
                         )
                 ),
                 fluidRow(
                         column(width = 4,
                                selectInput(inputId = "Ingredients3",
                                            label = NULL,
                                            choices =  c(Grains$Ingredients, Extracts$Ingredients, Adjuncts$Ingredients))
                         ),
                         column(width = 2,
                                numericInput(inputId = "IngredientPercent3",
                                             label = NULL,
                                             value = 0)
                         ),
                         column(width = 2,
                                verbatimTextOutput(outputId = "OG3")
                         )
                 ),
                 fluidRow(
                         column(width = 4,
                                selectInput(inputId = "Ingredients4",
                                            label = NULL,
                                            choices =  c(Grains$Ingredients, Extracts$Ingredients, Adjuncts$Ingredients))
                         ),
                         column(width = 2,
                                numericInput(inputId = "IngredientPercent4",
                                             label = NULL,
                                             value = 0)
                         ),
                         column(width = 2,
                                verbatimTextOutput(outputId = "OG4")
                         )
                 ),
                 fluidRow(
                         column(width = 4,
                                selectInput(inputId = "Ingredients5",
                                            label = NULL,
                                            choices =  c(Grains$Ingredients, Extracts$Ingredients, Adjuncts$Ingredients))
                         ),
                         column(width = 2,
                                numericInput(inputId = "IngredientPercent5",
                                             label = NULL,
                                             value = 0)
                         ),
                         column(width = 2,
                                verbatimTextOutput(outputId = "OG5")
                         )
                 ),
                 HTML("<br><br><br><br><br>")
        )
}