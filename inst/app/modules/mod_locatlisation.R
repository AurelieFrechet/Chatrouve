locatlisation_UI <- function(id) {
  ns <- NS(id)
  
  # Get GPS location of user
  js <- glue(
    '
      $(document).ready(function () {
        navigator.geolocation.getCurrentPosition(onSuccess, onError);

        function onError (err) {
          Shiny.onInputChange("<<geolocation>>", false);
        }

        function onSuccess (position) {
          setTimeout(function () {
            var coords = position.coords;
            console.log(coords.latitude + ", " + coords.longitude);
            Shiny.onInputChange("<<geolocation>>", true);
            Shiny.onInputChange("<<lat>>", coords.latitude);
            Shiny.onInputChange("<<long>>", coords.longitude);
          }, 1100)
        }
      });',
    geolocation = ns("geolocation"),
    lat = ns("lat"),
    long = ns("long"),
    .open = "<<",
    .close = ">>"
  )
  
  style <- glue(
    "
    #<<centercross>> {
          left: calc(50% - 10px);
          top: calc(50% - 10px);
          position: absolute;
          width: 20px;
          height: 20px;
          z-index: 10000;
          text-align: center;
          font-weight: normal;
          font-size: 16px;
          color: #222;
          text-shadow: 1px 1px 3px #fff;
    }
    #<<map>>{
      height: 100vh!important;
    }
    ",
    centercross = ns("centercross"),
    map = ns("map"),
    .open = "<<",
    .close = ">>"
  )
  
  tagList(
    tags$style(HTML(style)),
    tags$script(js),
    fluidRow(
      div(
        div(leafletOutput(ns("map"))),
        div(id = ns("centercross"), icon("paw"))
      )
    )
  )
  
}


locatlisation_SERVER <-
  function(id) {
    moduleServer(id, function(input, output, session) {
      center = reactiveValues()
      center$lng = 0
      center$lat = 0
      
      # If user is okay with geolocation
      observeEvent(input$geolocation, {
        if (input$geolocation) {
          center$lng = input$long
          center$lat = input$lat
        }
      })
      
      output$map <- renderLeaflet({
        map <- leaflet() %>%
          addProviderTiles(providers$Stamen.TonerLite,
                           options = providerTileOptions(noWrap = TRUE))
        
        if (!is.null(input$geolocation)) {
          map <- map %>% setView(lng = center$lng,
                                 lat = center$lat,
                                 zoom = 16)
        }
        
        map
      })
      
      
      # Change center location if the map is moved
      observeEvent(input$map_bounds, {
        center$lng = input$map_center$lng
        center$lat = input$map_center$lat
        
      })
      
      return(center)
      
    })
  }


# Test --------------------------------------------------------------------
library(shiny)
library(glue)
library(leaflet)

ui <- fluidPage(
  div(locatlisation_UI("test")),
                verbatimTextOutput("res"))

server <- function(input, output, session) {
  test <- locatlisation_SERVER("test")
  output$res <- renderPrint({
    reactiveValuesToList(test)
  })
}

shinyApp(ui, server)
