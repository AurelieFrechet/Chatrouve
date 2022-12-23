#' User
#'
#' @slot seen_at Date. Date time of the location
#' @slot lat numeric. lattitude of the location
#' @slot lng numeric. longitude of the location
setClass("User",
         slots = c(
           user_id  = "character",
           name     = "character",
           email    = "character",
           password = "character",
           cats     = "list"
         ))


# Initialize --------------------------------------------------------------

setMethod(
  f = "initialize",
  signature = "User",
  definition = function(.Object,
                        user_id,
                        name,
                        email,
                        password,
                        cats){
    .Object@user_id  <- user_id
    .Object@name     <- name
    .Object@email    <- email
    .Object@password <- password
    .Object@cats     <- cats
    return(.Object)
  }
)







  

