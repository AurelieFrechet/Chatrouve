db <- dbConnect(RSQLite::SQLite(), "../data/base_test.sqlite")

test_that("new cat", {
  
  expect_error(
    Norma <- new_cat(db,
       user_id      = "00000002",
       body_size    = "normal",
       fluffy       = FALSE,
       coat_pattern = "tabby",
       coat_color   = "cream",
       eyes_color   = "green",
       behavior     = "friendly",
       comments     = "", 
       seen_at      = as.POSIXct("2023-01-18 09:34:41 CET"),
       lat          = 48.12067501078443, 
       lng          = -1.7094192251069045
       ),
    NA
  )
  
  expect_equal(Norma@body_size,    "normal")
  expect_equal(Norma@fluffy,        FALSE)
  expect_equal(Norma@coat_pattern, "tabby")
  expect_equal(Norma@coat_color,   "cream")
  expect_equal(Norma@eyes_color,   "green")
  expect_equal(Norma@behavior,     "friendly")
  expect_equal(Norma@comments,     "")
  expect_equal(length(Norma@location), 1)
  expect_s4_class(Norma@location[[1]], "Location")
  Normaloc <- Norma@location[[1]]
  expect_equal(Normaloc@seen_at, as.POSIXct("2023-01-18 09:34:41 CET"))
  expect_equal(Normaloc@lat,     48.12067501078443)
  expect_equal(Normaloc@lng,     -1.7094192251069045)
})



dbDisconnect(db)