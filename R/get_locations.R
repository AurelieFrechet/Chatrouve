#' Get Locations
#' @include sql_requests.R
#' @param db database connexion
#' @param cat_id character. ID of the cat
#'
#' @return list of location
#' @export
get_locations <- function(db, cat_id) {
  res_location <- select_locations(db, cat_id)
  
  if(nrow(res_location) == 0) stop(paste("No locations found for cat_id", cat_id))
  
  list_location <- lapply(
    X   = 1:nrow(res_location),
    FUN = function(i) {
      return(
        new(
          Class = "Location",
          seen_at = res_location$seent_at[i],
          lat     = res_location$lat[i],
          lng     = res_location$lng[i]
        )
      )
    }
  )
  
  return(list_location)
}