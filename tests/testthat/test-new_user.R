db <- dbConnect(RSQLite::SQLite(), "../data/unit_testing.sqlite")
create_table_users(db)


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
    ),
    "email Aurelie@thebest already exists"
  )
})

dbDisconnect(db)