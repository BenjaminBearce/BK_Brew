# Hops Server

hopsServer <- function(input, output){
        output$hopsTotalGrain <- renderText({
                totalGrain()
        })
}