library(shiny)

# UI
multipages_UI <- function(id) {
  ns <- NS(id)
  
  fluidPage(title = "Page Navigation App",
            tags$style(
              HTML(
                "
                .breadcrumb {
                  background-color: #ffffff;
                  text-align: center;
                }
            
                .breadcrumb span,
                .breadcrumb a {
                  margin-right: 5px;
                  padding: 5px;
                  background-color: #ffffff;
                  border-radius: 3px;
                  color: #333333;
                  text-decoration: none;
                }
            
                .breadcrumb-selected {
                  font-weight: bold;
                }
            
                .breadcrumb-link {
                  cursor: pointer;
                }
            
                .breadcrumb-inactive {
                  color: #999999;
                }
              "
              )
            ),
            uiOutput(ns("pageContent")))
}

# Server -----------
multipages_SERVER <- function(id, pages_name, pages_content) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Number of pages
    nb_names    <- length(pages_name)
    nb_contents <- length(pages_content)
    if(nb_names != nb_contents) stop("Names and contents have different length")
    
    # Initialize page index
    currentPage <- reactiveVal(1)
    
    # Update page content
    output$pageContent <- renderUI({
      breadcrumb_links <- lapply(1:nb_names, function(i) {
        if (i == currentPage()) {
          tags$span(class = "breadcrumb-selected", pages_name[i])
        } else if (i < currentPage()) {
          tags$a(
            href = "#",
            class = "breadcrumb-link",
            onclick = sprintf("Shiny.setInputValue('%s', %d)", ns("currentPage"), i),
            pages_name[i]
          )
        } else {
          tags$span(class = "breadcrumb-inactive", pages_name[i])
        }
      })
      
      
      page_content <- pages_content[[currentPage()]]
      
      
      next_button <- if (currentPage() < nb_names) {
        actionButton(
          "nextBtn",
          "Next",
          onclick = sprintf(
            "Shiny.setInputValue('%s', %d)",
            ns("currentPage"),
            currentPage() + 1
          )
        )
      } else {
        NULL
      }
      
      fluidPage(div(class = "breadcrumb", do.call(tags$span, breadcrumb_links)),
                page_content,
                next_button)
    })
    
    # Handler for updating current page
    observeEvent(input$currentPage, {
      currentPage(input$currentPage)
    })
    
  })
}

# Test ----
library(shiny)

ui <- fluidPage(div(multipages_UI("test"))
                # verbatimTextOutput("res")
                )


server <- function(input, output, session) {
  test <- multipages_SERVER(
    id = "test",
    pages_name = c("What ?", "Where ?", "When ?"),
    pages_content = list(
      "1" = tagList(h1("Page 1"),
                    p("This is the content for Page 1")),
      "2" = h1("Page 2", "This is the content for Page 2"),
      "3" = h1("Page 3", "This is the content for Page 3")
    )
  )
  #   output$res <- renderPrint({
  #     reactiveValuesToList(test)
  #   })
}
shinyApp(ui, server)
