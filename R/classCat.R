#' class S4 Cat
#'
#' @slot id character. ID of the cat, composed of first letters of coat_pattern, coat_color and eyes_color 
#' and the datetime at the moment of creation
#' @slot body_size character. body_size of the cat, between "kitten", "small", "medium", "big"
#' @slot fluffy logical. Is the cat fluffy ?
#' @slot coat_pattern character. Pattern of the coat
#' @slot coat_color character. Color of the coat
#' @slot eyes_color character. Eyes color of the cat
#' @slot behavior character. Behavior type of the cat
#' @slot comments character. Any comments of the user
#' @slot location data.frame. date, lat and longituude of each occurence of the cat
setClass("Cat",
         slots = c(
           cat_id       = "character",
           body_size    = "character",
           fluffy       = "logical",
           coat_pattern = "character",
           coat_color   = "character",
           eyes_color   = "character",
           behavior     = "character",
           comments     = "character",
           location     = "data.frame"
         ))


# Initialize --------------------------------------------------------------

setMethod(
  f = "initialize",
  signature = "Cat",
  definition = function(.Object,
                        cat_id,
                        body_size,
                        fluffy,
                        coat_pattern,
                        coat_color,
                        eyes_color,
                        behavior,
                        comments,
                        seen_at,
                        lat,
                        lng) {
    
    .Object@cat_id       <- cat_id
    .Object@body_size    <- body_size
    .Object@fluffy       <- fluffy
    .Object@coat_pattern <- coat_pattern
    .Object@coat_color   <- coat_color
    .Object@eyes_color   <- eyes_color
    .Object@behavior     <- behavior
    .Object@comments     <- comments
    .Object@location     <- data.frame(seen_at = seen_at, 
                                       lat  = lat,
                                       lng = lng)
    
    return(.Object)
    
  }
)

#' Create new Cat
#' @include sql_requests.R
#' @import methods 
#' @param db database connexion
#' @param body_size character. body_size of the cat, between "kitten", "small", "medium", "big"
#' @param fluffy logical. Is the cat fluffy ?
#' @param coat_pattern character. Pattern of the coat
#' @param coat_color character. Color of the coat 
#' @param eyes_color character. Eyes color of the cat
#' @param behavior character. Behavior type of the cat
#' @param comments character. Any comments of the user
#' @param seen_at time. date time when the cas is seen
#' @param lat numeric. lat of the cat
#' @param lng numeric. lng of the cat
#'
#' @return Cat
#' @export

new_cat <- function(db,
                   body_size,
                   fluffy,
                   coat_pattern,
                   coat_color,
                   eyes_color,
                   behavior,
                   comments,
                   seen_at,
                   lat,
                   lng){
  
  cat_id <- toupper(paste0(
    substr(coat_pattern, 1, 1),
    substr(coat_color, 1, 1),
    substr(eyes_color, 1, 1),
    format(Sys.time(), "%Y%m%d%H%M%S")
  ))
  
  cat <- new("Cat", 
             cat_id       = cat_id,
             body_size    = body_size,
             fluffy       = fluffy,
             coat_pattern = coat_pattern,
             coat_color   = coat_color,
             eyes_color   = eyes_color,
             behavior     = behavior,
             comments     = comments,
             seent_at     = seen_at,
             lat    = lat,
             lng    = lng)
  
  insert_into_cats(db = db,
                   cat_id       = cat_id,
                   body_size    = body_size,
                   fluffy       = fluffy,
                   coat_pattern = coat_pattern,
                   coat_color   = coat_color,
                   eyes_color   = eyes_color,
                   behavior     = behavior,
                   comments     = comments)
  
  insert_into_location(db = db, 
                       cat_id  = cat_id, 
                       seen_at = seen_at, 
                       lat     = lat, 
                       lng     = lng)

 return(cat)  
}



# get a cat ---------------------------------------------------------------


# Add a cat location ------------------------------------------------------


