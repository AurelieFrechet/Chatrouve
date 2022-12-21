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
           password = "character"
         ))


# Initialize --------------------------------------------------------------

#' Title
#'
#' @param User 
#'
#' @return
#' @export
#'
#' @examples
setMethod(
  f = "initialize",
  signature = "User",
  definition = function(.Object,
                        user_id,
                        name,
                        email,
                        password){
    .Object@user_id  <- user_id
    .Object@name     <- name
    .Object@email    <- email
    .Object@password <- password
    
    return(.Object)
  }
)



#' new User
#' @importFrom uuid UUIDgenerate
#' @import bcrypt
#' @param db database connexion
#' @param name character. name chosen by the user
#' @param email character. email of the user, must not already exist in database
#' @param password character. password chosen by the user
#'
#' @return User object
#' @export
#'
#' @examples
newUser <- function(db, name, email, password){
  if(!exists_email(db, email)) stop(paste("email", email, "already exists"))
  
  user <- new(Class = "User", 
      user_id  = UUIDgenerate(),
      name     = name,
      email    = email,
      password = hashpw(password))
  

  insert_into_users(db,
                    user_id  = user@user_id,
                    name     = user@name,
                    email    = user@email,
                    password = user@password)
  
  return(user)
}