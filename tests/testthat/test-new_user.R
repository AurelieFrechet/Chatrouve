db <- dbConnect(RSQLite::SQLite(), "../data/base_test.sqlite")

test_that("new user", {
  
  expect_error(
    Aurelie <- new_user(
      db,
      name = "Aurélie",
      email = "Aurelie@thebest",
      password = "Pr0ut"
    ),
    NA
  )
  
  expect_equal(Aurelie@name, "Aurélie")
  expect_equal(Aurelie@email, "Aurelie@thebest")
  expect_true(Aurelie@password == "Pr0ut")
})



test_that("existing email", {
  expect_error(
    Aurelie <- new_user(
      db,
      name = "Aurélie",
      email = "Aurelie@thebest",
      password = "Pr0ut"
    )
  )
})

dbDisconnect(db)