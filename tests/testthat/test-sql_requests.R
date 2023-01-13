db <- dbConnect(RSQLite::SQLite(), "../data/unit_testing.sqlite")

# CREATE ----
test_that("create and delete table users", {
  expect_error(create_table_users(db), NA)
  expect_true(dbExistsTable(db, "users"))
})

test_that("create and delete table cats", {
  expect_error(create_table_cats(db), NA)
  expect_true(dbExistsTable(db, "cats"))
})

test_that("create and delete table locations", {
  expect_error(create_table_locations(db), NA)
  expect_true(dbExistsTable(db, "locations"))
})

# INSERT ----
test_that("insert values in table users", {
  expect_error(
    insert_into_users(
      db,
      user_id  = "00000001",
      name     = "Aurélien",
      email    = "Aurelien@mangedesfrites.be",
      password = "loulou"
    ),
    NA
  )
  
  expect_error(
    insert_into_users(
      db,
      user_id  = "00000002",
      name     = "Aurélien",
      email    = "Aurelien@mangedesfrites.be",
      password = "jaioubliemonmotdepasse"
    )
  )
  
})

test_that("insert values in table cats", {
  expect_error(
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
      user_id      = "00000001"
    ),
    NA
  )
})

test_that("insert values in table locations", {
  expect_error(
    insert_into_location(
      db,
      cat_id  = "TEST01",
      seen_at = "2023-01-13 12:20:23 CET",
      lat     = 29.975519613000223,
      lng     = 31.137621042180164
    ),
    NA
  )
  
})


# SELECT ----
test_that("select  users", {
  user <- select_user(db, email = "Aurelien@mangedesfrites.be")
  expect_equal(user$user_id, "00000001")
  expect_equal(user$name, "Aurélien")
  expect_equal(user$email, "Aurelien@mangedesfrites.be")
  expect_equal(user$password, "loulou")
  
  
  empty <- select_user(db, email = "Aurelien@chatrouvé.fr")
  expect_equal(nrow(empty), 0)
})


test_that("select  cats", {
  cats <- select_cats(db, user_id = "00000001")
  expect_equal(cats$cat_id, "TEST01")
  expect_equal(cats$body_size, "small")
  expect_equal(cats$fluffy, 1)
  expect_equal(cats$coat_pattern, "Tabby")
  expect_equal(cats$coat_color, "white")
  expect_equal(cats$eyes_color, "green")
  expect_equal(cats$behavior, "shy")
  expect_equal(cats$comments, "")
  expect_equal(cats$user_id, "00000001")
  
  
  empty <- select_cats(db, user_id = "00000002")
  expect_equal(nrow(empty), 0)
})


test_that("select location", {
  location <- select_locations(db, cat_id = "TEST01")
  expect_equal(location$seen_at, "2023-01-13 12:20:23 CET")
  expect_equal(location$lat, 29.975519613000223)
  expect_equal(location$lng, 31.137621042180164)
  
  empty <- select_locations(db, cat_id = "TEST02")
  expect_equal(nrow(empty), 0)
})



# EXISTS ----
test_that("existing users with email", {
  expect_true(exists_email(db, email = "Aurelien@mangedesfrites.be"))
  expect_false(exists_email(db, email = "Aurelien@chatrouvé.fr"))
})


# DELETE ----
test_that("delete table locations", {
  expect_error(delete_table_locations(db), NA)
  expect_false(dbExistsTable(db, "locations"))
})

test_that("delete table cats", {
  expect_error(delete_table_cats(db), NA)
  expect_false(dbExistsTable(db, "cats"))
})

test_that("delete table users", {
  expect_error(delete_table_users(db), NA)
  expect_false(dbExistsTable(db, "users"))
  
})


dbDisconnect(db)