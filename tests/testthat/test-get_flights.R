context("get_flights")

test_that("can find flights", {
  skip_if_offline()
  skip_on_cran()
  flights <- get_flights(asia[[1]], oceania[[1]])
  expect_true(length(flights) > 0)
})

test_that("no flights for wrong location", {
  skip_if_offline()
  skip_on_cran()
  expect_error(get_flights("WrongLocation"))
})
