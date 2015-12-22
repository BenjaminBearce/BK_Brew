# Water Server

waterServer <- function(input, output){
        output$WatertotalGrain <- renderText({
                totalGrain()
        })
        
}