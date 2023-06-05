draw_cat <-
  function(size         = "default", # Temp
           fluffy       = "default", # Temp
           coat_pattern = "solid", # Temp
           coat_color   = "yellow",
           eyes_color   = "black",
           pose         ="default" # Temp
           ) {
    drawing <-
      paste(readLines("inst/app/www/img/dessin.svg", warn = FALSE),
            collapse = " ")
    
    # Change eyes color
    drawing <- stringr::str_replace_all(string      = drawing,
                                        pattern     = "yellow",
                                        replacement = eyes_color)
    
    # Change coat color
    drawing <- stringr::str_replace_all(string      = drawing,
                                        pattern     = "black",
                                        replacement = coat_color)
  }