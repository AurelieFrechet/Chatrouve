#' Title
#' @include sql_requests.R
#' @param db database connexion
#' @param user_id character. ID of the user
#'
#' @return list of cats
#' @export
get_cats <- function(db, user_id){
  res_cats <- select_cats(db, user_id)
  
  if(nrow(res_cats) == 0) stop(paste("No locations found for user_id", user_id))
  
  list_cats <- lapply(
    X   = 1:nrow(res_cats),
    FUN = function(i) {
      new(Class = "Cat",
          cat_id       = res_cats$cat_id[i],
          body_size    = res_cats$body_size[i],
          fluffy       = res_cats$fluffy[i],
          coat_pattern = res_cats$coat_pattern[i],
          coat_color   = res_cats$coat_color[i],
          eyes_color   = res_cats$eyes_color[i],
          behavior     = res_cats$behavior[i],
          comments     = res_cats$comments[i],
          locations    = get_locations(db, res_cats$cat_id[i])
      )
      
    }
  )
  
  return(list_cats)
  
}