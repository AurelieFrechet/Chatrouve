catidentity_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
    column(width = 6,
           htmlOutput(ns("cat_picture"))),
    column(
      width = 6,
      # Size
      selectInput(
        inputId = ns("select_size"),
        label   = "Size",
        choices = size
      ),
      # Fluffyness
      radioButtons(
        inputId  = ns("select_fluffy"),
        label    = "Fluffy?",
        choices  = c("Yes", "No"),
        inline   = TRUE,
        selected = "No"
      ),
      # Pattern
      selectInput(
        inputId = ns("select_pattern"),
        label   = "Coat Pattern",
        choices = pattern$name
      ),
      # Color
      # uiOutput(ns("UI_color")),
      selectInput(
        inputId = ns("select_color_1"),
        label   = "Coat Color",
        choices = coat_color$name
      ),
      # Eyes
      selectInput(
        inputId = ns("select_eyes"),
        label   = "Eyes Color",
        choices = eyes_color$name
      ),
      # Behavior
      selectInput(
        inputId = ns("select_behavior"),
        label   = "Behavior",
        choices = behavior
      )
    )
  ),
  fluidRow(textAreaInput(inputId = "comments",
                         label   = "Comments")))
}

catidentity_SERVER <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    output$cat_picture <- renderText({
      readLines(con = "www/img/dessin.svg") %>%
        paste(collapse = " ") %>%
        # str_replace_all(pattern = "id\\s?=\\s?\"(\\w+)\"",
                        # replacement = paste0("id=\"", ns("\\1"),"\"")) %>% 
        HTML()
    })
    
    observe({
      runjs(  
        glue(
          '
      document.getElementById("body").style.fill="{coat_color}";
      document.getElementById("body").style.stroke="{coat_color}";
      document.getElementById("eyes").style.fill="{eyes_color}";
    ',
          # body = ns("body"),
          # eyes = ns("eyes"),
          coat_color = coat_color$color[coat_color$name == input$select_color_1],
          eyes_color = eyes_color$color[eyes_color$name == input$select_eyes]
        )
      )
    })
    
    
  })
}



# Test --------------------------------------------------------------------

ui <- fluidPage(useShinyjs(),
                catidentity_UI("test"))

server <- function(input, output, session) {
  catidentity_SERVER("test")
}

shinyApp(ui, server)
