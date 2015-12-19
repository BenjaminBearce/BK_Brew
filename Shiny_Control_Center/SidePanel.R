# Side Panel

sidePanel <- function() {
    sidebarPanel(style = "background-color: #BED4C9",
        h4("What Beer?"),
        textInput(inputId = "Brewer", label = "Brewer",value = "Big Kitchen"),
        textInput(inputId = "RecipeName", label = "Recipe Name",value = ""),
        selectInput(inputId = "Style", label = "BJCP Geneneral Beer Style",choices = unique(Styles$Styles)),
        textInput(inputId = "DateBrewed", label = "Date Brewed",value = Sys.time()),
        width = 2
    )
}