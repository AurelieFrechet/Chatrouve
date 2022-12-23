#' New location
#' @include sql_requests.R
#' @import methods 
#' @param db database connexion
#' @param cat_id character. ID of the cat
#' @param seen_at time. date time when the cas is seen
#' @param lat numeric. lattitude of the cat
#' @param lng numeric. longitude of the cat
#'
#' @return Location object
#' @export
new_location <- function(db, cat_id, seen_at, lat, lng){
  
  location <- new(Class   = "Location",
                  seen_at = seen_at,
                  lat     = lat,
                  lng     = lng)
  
  insert_into_location(db, 
                       cat_id  = cat_id, 
                       seen_at = seen_at, 
                       lat     = lat, 
                       lng     = lng)
  return(location)
}