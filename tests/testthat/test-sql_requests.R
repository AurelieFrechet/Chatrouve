# USERS ----
test_that("create and delete table users", {
  db <- dbConnect(RSQLite::SQLite(), "../data/unit_testing.sqlite")
  create_table_users(db)
  expect_true(dbExistsTable(db, "users"))
  delete_table_users(db)
  expect_false(dbExistsTable(db, "users"))
  dbDisconnect(db)
})


test_that("insert valid values in table users", {
  db <- dbConnect(RSQLite::SQLite(), "../data/unit_testing.sqlite")
  create_table_users(db)
  insert_into_users(
    db,
    user_id  = "Maxime",
    name     = "Maxime",
    email    = "Maxime@maxime.fr",
    password = "zouzou"
  )
  user <- select_user(db, email = "Maxime@maxime.fr")
  expect_equal(user$user_id, "Maxime")
  expect_equal(user$name, "Maxime")
  expect_equal(user$email, "Maxime@maxime.fr")
  expect_equal(user$password, "zouzou")
  
  expect_true(exists_email(db, email = "Maxime@maxime.fr"))
  expect_false(exists_email(db, email = "Maxime@chatrouvé."))
  dbDisconnect(db)
})



# CATS ----
test_that("create and delete table cats", {
  db <- dbConnect(RSQLite::SQLite(), "../data/unit_testing.sqlite")
  create_table_cats(db)
  expect_true(dbExistsTable(db, "cats"))
  delete_table_cats(db)
  expect_false(dbExistsTable(db, "cats"))
  dbDisconnect(db)
})

test_that("insert valid values in table cats", {
  db <- dbConnect(RSQLite::SQLite(), "../data/unit_testing.sqlite")
  create_table_cats(db)
  insert_into_cats(
    db,
    cat_id       = "TEST01",
    body_size    = "small",
    fluffy       = TRUE,
    coat_pattern = "Tabby",
    coat_color   = "white",
    eyes_color   = "green",
    behavior     = "shy",
    comments     = "",
    user_id      = "Maxime"
  )
  cats <- select_cats(db, user_id = "Maxime")
  expect_equal(cats$cat_id, "TEST01")
  expect_equal(cats$body_size, "small")
  expect_equal(cats$fluffy, 1)
  expect_equal(cats$coat_pattern, "Tabby")
  expect_equal(cats$coat_color, "white")
  expect_equal(cats$eyes_color, "green")
  expect_equal(cats$behavior, "shy")
  expect_equal(cats$comments, "")
  expect_equal(cats$user_id, "Maxime")
  dbDisconnect(db)
})


test_that("create and delete table locations", {
  db <- dbConnect(RSQLite::SQLite(), "../data/unit_testing.sqlite")
  create_table_locations(db)
  expect_true(dbExistsTable(db, "locations"))
  delete_table_locations(db)
  expect_false(dbExistsTable(db, "locations"))
  dbDisconnect(db)
})
