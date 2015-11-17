# Shiny practice for Brew Program

library(shiny, quietly = TRUE)

ui <- fluidPage(
        headerPanel("Testing Header for Brew Program"),
        selectInput('xcol','X Variable')
        
        
        
)

server <- function(input, output){
        
        
} 