library(DBI)

# Connect the database
mydb <- dbConnect(RSQLite::SQLite(), "sql/catabase.sqlite")

# Create table
dbSendQuery(mydb, paste(readLines("sql/create_cats.sql"), collapse = " "))

dbListTables(mydb)





# Disconnect
dbDisconnect(mydb)