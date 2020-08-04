library(shiny)
library(ggplot2)
library(CodeClanData)
library(dplyr)


ui <- fluidPage(
    
    sidebarLayout(
        
        sidebarPanel(
            
            radioButtons("colour",
                        label = h4('Colour of points'),
                        choices = c(Blue = "#3891A6", Yellow = "#FDE74C", Red = "#E3655B")
                        
            ),
            sliderInput("transparency", 
                        label = h4("Transparancy of points"), 
                        min = 0, 
                        max = 1, 
                        value = 0.7),
            
            selectInput("shape", 
                        label = h4("Select box"), 
                        choices = c("Square" = 15, "Circle" = 16, "Triangle" = 17)),
              
            textInput("text", 
                      label = h4("Title maker"), 
                      value = "Enter text...")
    
        ),
        mainPanel(
            plotOutput("histogram")
         )
    )
)
    
server <- function(input, output){
    
    student_data <- reactive({
        
      
        
        students_big %>% 
            filter(colour == input$colour) %>% 
            filter(transparency == input$shape) %>% 
            filter(shape == input$shape)
            
    })       
            output$histogram <- renderPlot({
                ggplot(student_data()) +
                    aes(x = reaction_time, y = score_in_memory_game) +
                    geom_histogram()
            })
        
    }
    
    


shinyApp(ui = ui, server = server)
