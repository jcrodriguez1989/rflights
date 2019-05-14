context("get_flights")

test_that("can find flights", {
  # testthat::skip_if_offline()
  skip_on_cran()
  flights <- get_flights("Cordoba")
  expect_true(length(flights) > 0)
})

test_that("no flights for wrong location", {
  # testthat::skip_if_offline()
  skip_on_cran()
  expect_error(get_flights("WrongLocation"))
})
