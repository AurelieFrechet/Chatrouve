draw_me_a_cat <- function(size,
                          flufflyness,
                          pattern,
                          coat_color,
                          eyes_color,
                          behavior) {
  

 readLines(con = "www/chat.txt") %>% 
    paste(collapse = " ") %>% 
    glue(eyes_color   = eyes_color,
         coat_color_1 = coat_color[1],
         coat_color_2 = coat_color[2],
         coat_color_3 = coat_color[3])

}


change_body_color <- function(color){
  
}

change_eyes_color <- function(color){
  
}