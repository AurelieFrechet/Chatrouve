catidentity_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(width = 6,
             htmlOutput(ns("cat_picture"))
             ),
      column(width = 6,
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
             uiOutput(ns("UI_color")),
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
    fluidRow(
      textAreaInput(inputId = "comments",
                    label   = "Comments")
    )
  )
}

catidentity_SERVER <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$cat_picture <- renderText({
      HTML(draw_me_a_cat(
        size        = "osef",
        flufflyness = "osef",
        pattern     = "mioum",
        coat_color  = coat_color$color[coat_color$name == input$select_color_1],
        eyes_color  = eyes_color$color[eyes_color$name == input$select_eyes],
        behavior    = "prout"
      ))
    })
    output$UI_color <- renderUI({
      n_pattern <- pattern$number[pattern$name == input$select_pattern]
      
      selectors <- lapply(X = 1:n_pattern,
                          function(i) {
                            selectInput(
                              inputId = session$ns(paste("select_color", i, sep = "_")),
                              label   = "Coat Color",
                              choices = coat_color$name
                            )
                          })
      
      tagList(selectors)
    })
  })
}



# Test --------------------------------------------------------------------

ui <- fluidPage(
  catidentity_UI("test")
)

server <- function(input, output, session) {
  catidentity_SERVER("test")
}

shinyApp(ui, server)
