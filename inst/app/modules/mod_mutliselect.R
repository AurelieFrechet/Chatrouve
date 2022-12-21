multiselect_UI <- function(id) {
  ns <- NS(id)
  
  tagList(
    uiOutput(ns("select_input")),
    verbatimTextOutput(ns("test"))
  )
  
}


multiselect_SERVER <- function(id, n, labels, choices, multiple = TRUE) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    output$select_input <- renderUI({
      select_input <-lapply(X = 1:n,
             function(i) {
               if(i != 1){
                 choices = choices[-(1:(i-1))]
               }
               column(
                 width = floor(12 / n),
                 selectInput(
                   inputId  = ns(paste("select", i, sep = "-")),
                   label    = labels[i],
                   choices  = choices,
                   selected = choices[i],
                   multiple = multiple
                 )
               )
             })
      tagList(fluidRow(select_input))
    })
    
  
    output$test <- renderPrint({
      sapply(
        X = 2:3,
        FUN = function(i) input[[paste("select", i, sep = "-")]]
      )
    })
    
    
    for (i in 2:n) {
      observeEvent(input[[paste("select", i, sep = "-")]], {
        selected_choices <- sapply(
          X = 2:i,
          FUN = function(i)
            input[[paste("select", i, sep = "-")]]
        )
        updateSelectInput(
          session = session,
          inputId = paste("select", i + 1, sep = "-"),
          choices = setdiff(choices, selected_choices)
        )
      })
      
    }
    
  })
}


# Test --------------------------------------------------------------------

ui <- fluidPage(multiselect_UI("test"))

server <- function(input, output, session) {
  multiselect_SERVER(
    id = "test",
    n = 3,
    labels = paste("Color", 1:3),
    choices = c(
      "white",
      "blue",
      "cream",
      "cinnamon",
      "red",
      "chocolate",
      "gray",
      "black"
    )
  )
}

shinyApp(ui, server)
