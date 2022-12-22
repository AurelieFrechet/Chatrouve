#' new User
#' @include  sql_requests.R
#' @importFrom uuid UUIDgenerate
#' @import bcrypt
#' @param db database connexion
#' @param name character. name chosen by the user
#' @param email character. email of the user, must not already exist in database
#' @param password character. password chosen by the user
#'
#' @return User object
#' @export
new_user <- function(db, name, email, password){
  if(exists_email(db, email)) stop(paste("email", email, "already exists"))
  
  user <- new(Class = "User", 
              user_id  = UUIDgenerate(),
              name     = name,
              email    = email,
              password = hashpw(password),
              cats     = list())
  
  
  insert_into_users(db,
                    user_id  = user@user_id,
                    name     = user@name,
                    email    = user@email,
                    password = user@password)
  
  return(user)
}