library(shiny)
library(tidyverse)
library(CodeClanData)
library(shinythemes)

all_teams <- unique(olympics_overall_medals$team)

# UI section 
ui <- fluidPage(
    
    theme = shinytheme("slate"),
    
    tabsetPanel(
        
        tabPanel("Olympic Medal Table"),
    
            sidebarLayout(
        
            sidebarPanel(
            
            radioButtons("season",
                         "Summer or Winter Olympics?",
                         choices = c("Summer", "Winter")
            ),
            
            radioButtons("medal",
                         "Medal Type?",
                         choices = c("Gold", "Silver", "Bronze")
            )
        ),
        
        mainPanel(
            plotOutput("medal_plot")
            
        )
    ),
    tabPanel("Website",
             tags$a("The Olympics website", href = "https://www.Olympic.org/")
        ),
    
    tabPanel("Logo",
             HTML(
                 "<h2>Olympic Fun Facts</h2>

                <ul>
                <li><h4>Gold medals are mostly made of silver.</h4> <br>Despite the popular belief that the Gold Medal is composed of pure gold, this hasn’t been the case since the 1912 Olympics. Today’s Olympic Gold Medal is an imposter, made almost entirely from silver with approximately 6 grams of gold to meet the standard laid out in the Olympic Charter. The 2018 Winter Olympics in PyeongChang, South Korea, are set to feature the heaviest Olympic medals ever, with the gold medal weighing in at 586 grams. With gold selling for around $1,350 an ounce, an Olympic medal made of pure gold would cost close to $28,000.</li>
                <li><h4>At least one of the Olympic Rings' colors appears in every national flag.</h4> <br>Baron Pierre de Coubertin, founder off the modern Olympic Movement, conceived of the five-ringed symbol. He specifically chose the different colors—blue, green, yellow, black, and red—because at least one of those colors appeared on all the national flags of the world.</li>
                <li><b>Only five countries have been represented at every modern-era Summer Olympic Games.</b> <br>Greece, Great Britain, France, Switzerland and Australia. </li>
                </ul>
                "
             )
                ),
    tabPanel("Graph",
             )
            )
    
)
         
            
            
            
            
            

# Server section 
server <- function(input, output) {
    output$medal_plot <- renderPlot(
        
        olympics_overall_medals %>%
            filter(team %in% c("United States",
                               "Soviet Union",
                               "Germany",
                               "Italy",
                               "Great Britain")) %>%
            filter(medal == input$medal) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = team, y = count) +
            geom_col()
    )
}

# Run the app
shinyApp(ui = ui, server = server)

