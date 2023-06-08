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



#' Select locations
#' @import DBI
#' @param db database connexion
#' @param cat_id character. ID of the cat
#'
#' @return data.frame
select_locations <- function(db, cat_id){
  res <- dbGetQuery(db, 'SELECT * FROM locations WHERE  cat_id = :cat_id',
                    params = list(cat_id = cat_id))
  return(res)
}



#' Delete location table
#' @import DBI
#' @param db database connexion
delete_table_locations <- function(db){
  if (dbExistsTable(db, "locations")) DBI::dbRemoveTable(db, "locations")
}