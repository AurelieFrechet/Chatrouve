# UI ----------------------------------------------------------------------
drawcat_UI <- function(id) {
  ns <- NS(id)
  tagList(uiOutput(ns("cat_picture")))
}



# SERVER ------------------------------------------------------------------

drawcat_SERVER <- function(id, eyes_color, coat_color) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    output$cat_picture <- renderUI({
      HTML(
        draw_cat(
          eyes_color = eyes_color, 
          coat_color = coat_color
      )
      )
    })
  })
}



# Test --------------------------------------------------------------------
library(shiny)
library(stringr)
library(shinyjs)

ui <- fluidPage(useShinyjs(),
                drawcat_UI("test"),
                drawcat_UI("test2"),
                verbatimTextOutput("drawing"))

server <- function(input, output, session) {
  drawcat_SERVER("test",
                 coat_color = "#e5aa8c",
                 eyes_color = "#24d4f9")
  drawcat_SERVER("test2",
                 eyes_color = "#e5fa8c",
                 coat_color = "#f4d3f9")
}

shinyApp(ui, server)
