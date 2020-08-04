library(shiny)
library(ggplot2)
library(CodeClanData)
library(shinythemes)
library(tidyverse)
library(dplyr)


ui <- fluidPage(
    theme = shinytheme("slate"),
    
    titlePanel("Sales"),
    
    sidebarLayout(
        sidebarPanel(
            selectInput("Year", 
                        label = h3("Year"), 
                        choices = unique(game_sales$year_of_release)
            )
        ),
        
        mainPanel(
            plotOutput("sales_plot") 
        
    )
    )
)
tab



server <- function(input, output) {
    
    output$sales_plot <- renderPlot(
        
        
        game_sales %>%
            filter(team %in% c("United States",
                               "Soviet Union",
                               "Germany",
                               "Italy",
                               "Great Britain")) %>%
            filter(Year == input$year_of_release) %>%
            filter(Sales == input$sales) %>%
            ggplot() +
            aes(x = year, y = sales) +
            geom_col()
    )
}


shinyApp(ui = ui, server = server)
