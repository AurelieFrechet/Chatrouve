
# Create table ------------------------------------------------------------

#' Create table Cats
#' @import DBI
#' @param db database connexion
#' @return NULL
create_table_cats <- function(db){
  if (dbExistsTable(db, "cats")) DBI::dbRemoveTable(db, "cats")
  
  res <- DBI::dbSendQuery(db, 
  "CREATE TABLE cats (
    cat_id       TEXT PRIMARY KEY,
    body_size    TEXT,
    fluffy       INTEGER,
    coat_pattern TEXT,
    coat_color   TEXT,
    eyes_color   TEXT,
    behavior     TEXT,
    comments     TEXT,
    user_id      TEXT,
    FOREIGN KEY (user_id)
       REFERENCES users (user_id) 
  );"
  )
  dbClearResult(res)
  return(NULL)
}


#' Create table Locations
#' @import DBI
#' @param db database connexion
#' @return NULL
create_table_locations <- function(db){
  if (dbExistsTable(db, "locations")) DBI::dbRemoveTable(db, "locations")
  res <- DBI::dbSendQuery(db, 
  "CREATE TABLE locations (
    cat_id  TEXT,
    seen_at INTEGER,
    lat     REAL,
    lng     REAL,
    FOREIGN KEY (cat_id)
       REFERENCES cats (cat_id) 
  );"
  )
  dbClearResult(res)
  return(NULL)
}

create_table_users <- function(db){
  if (dbExistsTable(db, "users")) DBI::dbRemoveTable(db, "users")
  res <- DBI::dbSendQuery(db, 
  "CREATE TABLE users (
    user_id  TEXT PRIMARY KEY,
    name     TEXT,
    email    TEXT UNIQUE,
    password TEXT
  );"
  )
  dbClearResult(res)
  return(NULL)
}
  

# Insert rows -------------------------------------------------------------

#' Insert cat into database
#' @import DBI
#' @param db database connexion
#' @param cat_id character. ID of the cat
#' @param body_size character. body_size of the cat, between "kitten", "small", "medium", "big"
#' @param fluffy logical. Is the cat fluffy ?
#' @param coat_pattern character. Pattern of the coat
#' @param coat_color character. Color of the coat 
#' @param eyes_color character. Eyes color of the cat
#' @param behavior character. Behavior type of the cat
#' @param comments character. Any comments of the user
#' @param user_id character. ID of the user
#'
#' @return NULL
insert_into_cats <- function(db,
                             cat_id,
                             body_size,
                             fluffy,
                             coat_pattern,
                             coat_color,
                             eyes_color,
                             behavior,
                             comments,
                             user_id) {
  res <- DBI::dbSendQuery(
    db,
    'INSERT INTO cats (cat_id, body_size, fluffy, coat_pattern, coat_color, eyes_color, behavior, comments, user_id)
      VALUES (:cat_id, :body_size, :fluffy, :coat_pattern, :coat_color, :eyes_color, :behavior, :comments, :user_id)',
    params = list(
      cat_id       = cat_id,
      body_size    = body_size,
      fluffy       = fluffy,
      coat_pattern = coat_pattern,
      coat_color   = coat_color,
      eyes_color   = eyes_color,
      behavior     = behavior,
      comments     = comments,
      user_id      = user_id
    )
  )
  dbClearResult(res)
  return(NULL)
}


#' Insert Into Location
#' @import DBI
#' @param db database connexion
#' @param cat_id character. ID of the cat
#' @param seen_at time. date time when the cas is seen
#' @param lat numeric. lattitude of the cat
#' @param lng numeric. longitude of the cat
#'
#' @return NULL
insert_into_location <- function(db, cat_id, seen_at, lat, lng){
  res <- DBI::dbSendQuery(db, 'INSERT INTO locations (cat_id, seen_at, lat, lng)
                          VALUES (:cat_id, :seen_at, :lat, :lng)',
              params = list(
                cat_id  = cat_id,
                seen_at = seen_at, 
                lat     = lat, 
                lng     = lng
              ))
  dbClearResult(res)
  return(NULL)
}


#' Insert Into Users
#' @import DBI
#' @param db database connexion
#' @param cat_id character. ID of the cat
#' @param seen_at time. date time when the cas is seen
#' @param lat numeric. lattitude of the cat
#' @param lng numeric. longitude of the cat
#'
#' @return NULL
insert_into_users <- function(db, user_id, name, email, password){
  res <- DBI::dbSendQuery(db, 'INSERT INTO users (user_id, name, email, password)
                          VALUES (:user_id, :name, :email, :password)',
                          params = list(
                            user_id   = user_id,
                            name      = name, 
                            email     = email, 
                            password  = password
                          ))
  dbClearResult(res)
  return(NULL)
}

# Select --------------------------------------------------------

#' Select cats
#' @import DBI
#' @param db database connexion
#' @param cat_id character. ID of the cat
#'
#' @return data.frame
select_cats <- function(db, cat_id){
  res <- dbGetQuery(db, 'SELECT * FROM cats WHERE  cat_id = :cat_id',
             params = list(cat_id = cat_id))
  return(res)
}

#' Select locations
#' @import DBI
#' @param db database connexion
#' @param cat_id character. ID of the cat
#'
#' @return data.frame
select_location <- function(db, cat_id){
  res <- dbGetQuery(db, 'SELECT * FROM locations WHERE  cat_id = :cat_id',
                    params = list(cat_id = cat_id))
  return(res)
}


#' Select user
#' @import DBI
#' @param db database connexion
#' @param email character. ID of the cat
#'
#' @return data.frame
select_user <- function(db, email){
  res <- dbGetQuery(db, 'SELECT * FROM users WHERE  email = :email',
                    params = list(email = email))
  return(res)
}



# Exists ------------------------------------------------------------------


#' Select user
#' @import DBI
#' @param db database connexion
#' @param email character. ID of the cat
#'
#' @return data.frame
exists_email <- function(db, email){
  res <- dbGetQuery(db, 'SELECT * FROM users WHERE  email = :email',
                    params = list(email = email))

  return(nrow(res)>0)
}


# Delete table ------------------------------------------------------------

delete_table_cats <- function(db){
  if (dbExistsTable(db, "cats")) DBI::dbRemoveTable(db, "cats")
}

delete_table_locations <- function(db){
  if (dbExistsTable(db, "locations")) DBI::dbRemoveTable(db, "locations")
}

delete_table_users <- function(db){
  if (dbExistsTable(db, "users")) DBI::dbRemoveTable(db, "users")
}
