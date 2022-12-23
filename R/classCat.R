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
#' @slot location list of Location
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
           location     = "list"
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
                        location) {
    
    .Object@cat_id       <- cat_id
    .Object@body_size    <- body_size
    .Object@fluffy       <- fluffy
    .Object@coat_pattern <- coat_pattern
    .Object@coat_color   <- coat_color
    .Object@eyes_color   <- eyes_color
    .Object@behavior     <- behavior
    .Object@comments     <- comments
    .Object@location     <- location
    
    return(.Object)
    
  }
)

