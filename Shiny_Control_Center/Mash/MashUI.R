# Mash UI

mashUI <- function(){
tabPanel("Mash", 
         fluidRow(
                 column(width = 4,selectInput(inputId = "MashType1",
                                              label = "MashType",
                                              choices =  c("Step Mash (using direct heat)",
                                                           "Step Mash (using infusions)",
                                                           "Single Decoction"))
                 )
         ),
         fluidRow(
                 column(width=2,uiOutput("mashType")),
                 column(width=2,strong("You win!!"),textOutput("mashNum"))
         ),
         HTML("<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>")
)
}