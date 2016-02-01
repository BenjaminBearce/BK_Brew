# Hops Server

hopsServer <- function(input, output){
        output$hopsUtilization1 <- renderText({
                "Utilization1"
        })
        output$hopsUtilization2 <- renderText({
                "Utilization2"
        })
        output$hopsUtilization3 <- renderText({
                "Utilization3"
        })
        output$hopsUtilization4 <- renderText({
                "Utilization4"
        })
        output$hopsUtilization5 <- renderText({
                "Utilization5"
                
        })
        
        output$hopsIBU1 <- renderText({
                "IBU1"
        })
        output$hopsIBU2 <- renderText({
                "IBU2"
        })
        output$hopsIBU3 <- renderText({
                "IBU3"
        })
        output$hopsIBU4 <- renderText({
                "IBU4"
        })
        output$hopsIBU5 <- renderText({
                "IBU5"
                
        })
}