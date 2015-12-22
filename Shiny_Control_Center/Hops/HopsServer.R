# Hops Server

hopsServer <- function(input, output){
        output$HopstotalGrain <- renderText({
                totalGrain()
        })
}