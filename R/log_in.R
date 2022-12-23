#' Log In
#' @include  sql_requests.R
#' @import bcrypt
#' @param db database connexion
#' @param email character. email of the user, must not already exist in database
#' @param password character. password chosen by the user
#'
#' @return User object
#' @export
log_in <- function(db, email, password){
  if(!exists_email(db, email)) stop(paste("email", email, "doesn't exists"))
  
  user <- select_user(db, email)
  
  res <- identical(user$password, bcrypt::hashpw(password, user$password)) 
  
  if(res){
    cats <- select_cats(db, user_id = user$user_id)
    
    
    
    obj_user <- new(Class = "User", 
                    user_id  = user$user_id,
                    name     = user$name,
                    email    = user$email,
                    password = user$password)
  }
}