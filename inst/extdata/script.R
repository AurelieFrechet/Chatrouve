library(rjson)

cats_names_EN <- fromJSON(file = "inst/extdata/catnames.json")

db <- dbConnect(RSQLite::SQLite(), "inst/extdata/catabase.sqlite")
create_table_users(db)
create_table_cats(db)
create_table_users(db)