#' Location
#'
#' @slot seen_at Date. Date time of the location
#' @slot lat numeric. lattitude of the location
#' @slot lng numeric. longitude of the location
setClass("Location",
         slots = c(
           seen_at = "Date",
           lat     = "numeric",
           lng     = "numeric"
         ))


# Initialize --------------------------------------------------------------

setMethod(
  f = "initialize",
  signature = "Location",
  definition = function(.Object,
                        seen_at,
                        lat,
                        lng){
    .Object@seent_at <- seen_at
    .Object@lat      <- lat
    .Object@lng      <- lng
    
    return(.Object)
  }
)




