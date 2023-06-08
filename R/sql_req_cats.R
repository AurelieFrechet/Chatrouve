
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



#' Select cats
#' @import DBI
#' @param db database connexion
#' @param user_id character. ID of the user
#'
#' @return data.frame
select_cats <- function(db, user_id){
  res <- dbGetQuery(db, 'SELECT * FROM cats WHERE  user_id = :user_id',
                    params = list(user_id = user_id))
  return(res)
}



#' delete cat table
#' @import DBI
#' @param db database connexion
delete_table_cats <- function(db){
  if (dbExistsTable(db, "cats")) DBI::dbRemoveTable(db, "cats")
}