# UI ----------------------------------------------------------------------

catcard_UI <- function(id) {
  ns <- NS(id)
  tagList(
    tags$style('
    .card {
      width: 250px;
      clear: both;
      /* Add shadows to create the "card" effect */
      box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
      transition: 0.3s;
    }
      
   /* On mouse-over, add a deeper shadow */
   .card:hover {
      box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
   }
   
   /* Add some padding inside the card container */
   .container {
     width: 250px;
     padding: 2px 2px;
   }
               
    .card svg {
      max-width: 100%;
      max-height: 100%;
    }'
    ),
    uiOutput(ns("card"))
  )
}


# SERVER ------------------------------------------------------------------

catcard_SERVER <- function(id, name, eyes_color, coat_color) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    output$card <- renderUI({
      div(class = "card",
          HTML(draw_cat(eyes_color = eyes_color,
                       coat_color = coat_color)),
          div(class = "container",
              h3(name, align = "center"))
          )
      
    })
  })
}


# TEST --------------------------------------------------------------------
# library(shiny)
# source("R/draw_cat.R")

# ui <- fluidPage(catcard_UI("test"),
#                 catcard_UI("test2"))
# 
# server <- function(input, output, session) {
#   catcard_SERVER("test",
#                  name = "Bob",
#                  coat_color = "#e5aa8c",
#                  eyes_color = "#24d4f9")           
#   catcard_SERVER("test2",
#                  name = "Alice",
#                  eyes_color = "#e5fa8c",
#                  coat_color = "#f4d3f9")
# }
# 
# shinyApp(ui, server)