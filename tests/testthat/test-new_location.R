db <- dbConnect(RSQLite::SQLite(), "../data/base_test.sqlite")

test_that("new location for existing cat", {
  expect_error(
    location <- new_location(
      db,
      cat_id  = "TEST01",
      seen_at = as.POSIXct("2023-01-19 12:38:08 CET"),
      lat     = 48.11803410122812,
      lng     =  -1.649440843462419
    ),
    NA
  )
  
  expect_equal(location@seen_at, as.POSIXct("2023-01-19 12:38:08 CET"))
  expect_equal(location@lat, 48.11803410122812)
  expect_equal(location@lng, -1.649440843462419)
})


test_that("new location for non-existing cat", {
  expect_error(
    location <- new_location(
      db,
      cat_id  = "TEST05",
      seen_at = as.POSIXct("2023-01-19 12:38:08 CET"),
      lat     = 48.11803410122812,
      lng     =  -1.649440843462419
    ),
    NA
  )
  
  expect_equal(location@seen_at, as.POSIXct("2023-01-19 12:38:08 CET"))
  expect_equal(location@lat, 48.11803410122812)
  expect_equal(location@lng, -1.649440843462419)
})

dbDisconnect(db)