# Mash UI

mashUI <- function(){
tabPanel("Mash", 
         fluidRow(
                 column(width = 4,selectInput(inputId = "MashType1",
                                              label = "MashType",
                                              choices =  c("Step Mash (using direct heat)",
                                                           "Step Mash (using infusions)",
                                                           "Single Decoction",
                                                           "Classic Double Decoction",
                                                           "Enhanced Double Decoction",
                                                           "Hochkurz Double Decoction"))
                 )
         ),
         fluidRow(
                 column(width=4,numericInput("GrainTemp1","Grain Temperature",72.0))
         ),
         fluidRow(
                 column(width=4,numericInput("ProteinRest1","Protein Rest Temp",130.0))
         ),
         fluidRow(
                 column(width=4,strong("Strike Temp"),verbatimTextOutput("MashTemp"))
         ),
         fluidRow(
                 column(width=4,uiOutput("mashType"))
         ),
         fluidRow(
                 column(width=2,strong("You win!!"),verbatimTextOutput("mashNum"))
         ),
         HTML("<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>")
)
}
