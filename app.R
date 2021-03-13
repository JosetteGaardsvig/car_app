#
#     MY VERSION OF THE SHINY APP - 2020-03-12
#
#This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(tidyverse)

library(dplyr)

library(readxl)
passat <- read_excel("C:/Users/joset/Desktop/Skrivebordsmappe/Datanalyse-Noter/passat.xlsx")
#View(passat)



# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Dataanalyse 2021", title = div(img(heigth=100, width=125,src="dania-logo.png"))),
    
    theme = shinytheme("superhero"),
    
    headerPanel("Dette er vores web app"),

    
sidebarLayout(
    
    sidebarPanel("",
                 selectInput("xaxis", label = "Vælg x-akse", choices = names(passat), "km_per_liter", TRUE, multiple = FALSE),
                 selectInput("yaxis", label = "Vælg y-akse", choices = names(passat), multiple = FALSE),
                 selectInput("data_input", label= "Vælg datasæt", choices =  c("mtcars", "faitful", "iris"))),
                 
    mainPanel("", 
              
              tabsetPanel(id = "tabs",
                          tabPanel("Plot", plotOutput("plot")),
                          tabPanel("Tabel", tableOutput("tabel"))))
    
    
    
   
)
)



server <- function(input, output) {
    
output$plot <- renderPlot ({
    
    ggplot(passat, aes_string(x = as.name(input$xaxis), y = as.name(input$yaxis))) +
        geom_point()
})



getdata <- reactive({
    
    get(input$data_input, "package:datasets")
    
})
    output$tabel <- renderTable({head(getdata())})

}

# Run the application 
shinyApp(ui = ui, server = server)
