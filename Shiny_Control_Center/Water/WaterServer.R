# Water Server

waterServer <- function(input, output){
        output$waterTotalGrain <- renderText({
                totalGrain()
        })
        
}