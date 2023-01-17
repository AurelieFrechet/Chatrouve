db <- dbConnect(RSQLite::SQLite(), "../data/base_test.sqlite")

#  Tables Creations ------------------------------------------------------------
test_that("create database", {
  expect_error(create_table_users(db), NA)
  expect_error(create_table_cats(db), NA)
  expect_error(create_table_locations(db), NA)
})

# Add users --------------------------------------------------------------------
test_that("add users", {
  expect_error(
    insert_into_users(
      db,
      user_id  = "00000001",
      name     = "Aurélien",
      email    = "aurelien@mangedesfrites.be",
      password = "loulou"
    ),
    NA
  )
  
  expect_error(
    insert_into_users(
      db,
      user_id  = "00000002",
      name     = "Aurélie",
      email    = "aurelie@chatrouve.fr",
      password = "motdepasse"
    ),
    NA
  )
})


# Add cats ---------------------------------------------------------------------
test_that("add cats", {
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
  
  expect_error(
    insert_into_cats(
      db,
      cat_id       = "TEST02",
      body_size    = "normal",
      fluffy       = FALSE,
      coat_pattern = "van",
      coat_color   = "black",
      eyes_color   = "yellow",
      behavior     = "aggressive",
      comments     = "",
      user_id      = "00000001"
    ),
    NA
  )
  
  expect_error(
    insert_into_cats(
      db,
      cat_id       = "TEST03",
      body_size    = "normal",
      fluffy       = FALSE,
      coat_pattern = "calico",
      coat_color   = "white",
      eyes_color   = "yellow",
      behavior     = "friendly",
      comments     = "",
      user_id      = "00000002"
    ),
    NA
  )
})

# Add locations ---------------------------------------------------------------
test_that("add locations", {
  expect_error(
    insert_into_location(
      db,
      cat_id  = "TEST01",
      seen_at = "2023-01-13 12:20:23 CET",
      lat     = 48.115094422254565,
      lng     = -1.6792410144340117
    ),
    NA
  )
  
  expect_error(
    insert_into_location(
      db,
      cat_id  = "TEST01",
      seen_at = "2023-01-17 10:12:56 CET",
      lat     = 48.1123100870982,
      lng     = -1.6825344004623053
    ),
    NA
  )
  
  expect_error(
    insert_into_location(
      db,
      cat_id  = "TEST02",
      seen_at = "2023-01-15 17:22:43 CET",
      lat     = 48.1123100870982,
      lng     = -1.6825344004623053
    ),
    NA
  )
  
  expect_error(
    insert_into_location(
      db,
      cat_id  = "TEST03",
      seen_at = "2023-01-15 18:22:43 CET",
      lat     = 48.1123100870982,
      lng     = -1.6825344004623053
    ),
    NA
  )
})

dbDisconnect(db)