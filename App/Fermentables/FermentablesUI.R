# Fermentables UI

fermentablesUI <- function(){
tabPanel("Fermentables",
         fluidRow(
                 column(width = 2,
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
                        textOutput(outputId = "OG1")
                 ),
                 column(width = 2,
                        strong("Total Grains (Lbs)"),
                        textOutput(outputId = "fermentablesTotalGrain")
                 )
                 
         ),
         fluidRow(
                 column(width = 2,
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
                        textOutput(outputId = "OG2")
                 )
         ),
         fluidRow(
                 column(width = 2,
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
                        textOutput(outputId = "OG3")
                 )
         ),
         fluidRow(
                 column(width = 2,
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
                        textOutput(outputId = "OG4")
                 )
         ),
         fluidRow(
                 column(width = 2,
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
                        textOutput(outputId = "OG5")
                 )
         )
)
}