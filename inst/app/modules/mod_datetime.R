

# UI --------------------------------------------------------------------------
datetime_UI <- function(id){
  ns <- NS(id)
  
  tagList(
    tags$head(
      tags$style(HTML("
      .datetime-container {
        display: flex;
        align-items: flex-start;
        
      }

      .datetime-container .date-container {
        max-width: 100px;
      }
    "))
    ),
    div(
      class = "datetime-container",
      div(class = "date-container",
          dateInput(
            inputId = ns("alarmDate"),
            label   = "",
            value   = Sys.time(),
            format  = "yyyy-mm-dd"
          )
      ),
      div(class = "time-container",
          timeInput(
            inputId = ns("alarmTime"),
            label   = "",
            value   = Sys.time(),
            second  = FALSE
          )
      )
    )
  )
}



# Server -----------------------------------------------------------------------
datetime_SERVER <- function(id) {
  moduleServer(id, function(input, output, session) {
    # Store the selected date and time
    alarmDateTime <- reactive({
      req(input$alarmDate, input$alarmTime)
      as.POSIXct(paste(input$alarmDate, input$alarmTime))
    })
    
    return(reactive(alarmDateTime()))
    
  })
}


# Test --------------------------------------------------------------------
# library(shiny)
# library(shinyTime)
# 
# ui <- fluidPage(datetime_UI("test"),
#                 verbatimTextOutput("res"))
# 
# server <- function(input, output, session) {
#   test <- datetime_SERVER("test")
#   output$res <- renderPrint({
#     test()
#   })
# }
# 
# shinyApp(ui, server)
