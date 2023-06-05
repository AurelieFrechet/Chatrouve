# UI ----------------------------------------------------------------------
gallery_UI <- function(id) {
  tagList(uiOutput(ns("cards")))
}


# SERVER ------------------------------------------------------------------

gallery_SERVER <- function(id, cat_list) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # number of cats
    n <- length(cat_list)
    
    # Card for each cat
    lapply(1:n, function(i) {
      catcard_SERVER(
        paste0("cat", i),
        name       = cat_list[[i]]$name,
        coat_color = cat_list[[i]]$coat_color,
        eyes_color = cat_list[[i]]$eyes_color
      )
    })
    
    output$cards <- renderUI({
      # First make the cards
      args <- lapply(1:n, function(i) {
        catcard_UI(ns(paste0("cat", i)))
      })
      
      # Make sure to add other arguments to the list:
      args$cellArgs <- list(style = "
        width: auto;
        height: auto;
        margin: 5px;
        ")
      
      # basically the same as flowLayout(cards[[1]], cards[[2]],...)
      do.call(shiny::flowLayout, args)
      
    })
  })
}


# TEST --------------------------------------------------------------------
library(shiny)

source("inst/app/modules/mod_catcard.R")
source("R/draw_cat.R")

ui <- fluidPage(gallery_UI("test"))

server <- function(input, output, session) {
  gallery_SERVER("test",
                 cat_list = list(
                   list(
                     name = "Bob",
                     coat_color = "#e5aa8c",
                     eyes_color = "#24d4f9"
                   ),
                   list(
                     name = "Alice",
                     eyes_color = "#e5fa8c",
                     coat_color = "#f4d3f9"
                   )
                 ))
}

shinyApp(ui, server)


# TEST --------------------------------------------------------------------

shinyApp(ui, server)