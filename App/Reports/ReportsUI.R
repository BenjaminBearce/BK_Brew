# Reports UI

reportsUI <- function(){
        tabPanel("Reports",
        	fluidRow(
        	        column(width = 12,
        	               textInput(inputId = "recipe", label = "Recipe Name:"),
        	               actionButton("submit", "Save")#DT::dataTableOutput("responses", width = 300),
        	               
        	        ),
        	        column(width = 4,
        	               h4("Predicted:"),
        	               fluidRow(
        	               fluidRow(column(width = 1),column(uiOutput("reportPredictedOG"), width = 4),column(uiOutput("reportPredictedFG"), width = 3)),
        	               fluidRow(column(width = 1),column(uiOutput("reportPredictedABV"), width = 4),column(uiOutput("reportPredictedIBU"), width = 3)),
        	               fluidRow(column(width = 1),column(uiOutput("reportPredictedSRM"), width = 7))
        	               ),
        	               h4("Actual:"),
        	               fluidRow(
          	               fluidRow(column(width = 1),column(uiOutput("reportActualOG"), width = 4),column(uiOutput("reportActualFG"), width = 3)),
          	               fluidRow(column(width = 1),column(uiOutput("reportActualABV"), width = 7))
        	               ),
        	               h4("Fermentables:"),
        	               fluidRow(
          	               fluidRow(column(width = 1),column(width = 4, uiOutput("reportIngredient1")),column(width = 3, uiOutput("reportIngWeight1"))),
          	               fluidRow(column(width = 1),column(width = 4, uiOutput("reportIngredient2")),column(width = 3, uiOutput("reportIngWeight2"))),
          	               fluidRow(column(width = 1),column(width = 4, uiOutput("reportIngredient3")),column(width = 3, uiOutput("reportIngWeight3"))),
          	               fluidRow(column(width = 1),column(width = 4, uiOutput("reportIngredient4")),column(width = 3, uiOutput("reportIngWeight4"))),
          	               fluidRow(column(width = 1),column(width = 4, uiOutput("reportIngredient5")),column(width = 3, uiOutput("reportIngWeight5")))
        	               ),
        	               h4("Yeast:"),
        	               fluidRow(
        	                 fluidRow(column(width = 1),column(width = 4, uiOutput("reportYeastName")),column(width = 3, uiOutput("reportYeastAttenuation"))),
        	                 fluidRow(column(width = 1),column(width = 7, uiOutput("reportStarter")))
        	               )
        	        ),
        	        column(width = 4,
        	               h4("Mash Schedule:"),
        	               fluidRow(
        	                 column(width = 12,plotOutput(outputId = "reportsStepMashPlot"))
        	               ),
                	       fluidRow(
                	         fluidRow(column(uiOutput("reportSaccRestTemp"), width = 4),column(uiOutput("reportInfTemp"), width = 4),column(uiOutput("reportSaccRestDuration"), width = 4)),
                	         fluidRow(column(uiOutput("reportMashVol"),width = 6),column(uiOutput("reportMashOutVol"), width = 6))
                	       ),
        	               h4("Boil\\Hop Schedule:"),
        	               fluidRow(
        	                 fluidRow(column(width = 6, uiOutput("reportHop1"))),
        	                 fluidRow(column(width = 4, uiOutput("reportHopWeight1")),column(width = 4, uiOutput("reportHopBoilTime1"))),
        	                 fluidRow(column(width = 6, uiOutput("reportHop2"))),
        	                 fluidRow(column(width = 4, uiOutput("reportHopWeight2")),column(width = 4, uiOutput("reportHopBoilTime2"))),
        	                 fluidRow(column(width = 6, uiOutput("reportHop3"))),
        	                 fluidRow(column(width = 4, uiOutput("reportHopWeight3")),column(width = 4, uiOutput("reportHopBoilTime3"))),
        	                 fluidRow(column(width = 6, uiOutput("reportHop4"))),
        	                 fluidRow(column(width = 4, uiOutput("reportHopWeight4")),column(width = 4, uiOutput("reportHopBoilTime4"))),
        	                 fluidRow(column(width = 6, uiOutput("reportHop5"))),
        	                 fluidRow(column(width = 4, uiOutput("reportHopWeight5")),column(width = 4, uiOutput("reportHopBoilTime5")))
        	               )
        	        ),
        	        column(width = 4,
        	               h4("Fermentation:"),
        	               fluidRow(
        	                       column(width = 12,plotOutput(outputId = "reportsFermentationPlot"))
        	               )
        	        )
        	)
        )
}