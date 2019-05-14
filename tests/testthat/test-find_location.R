context("find_location")

test_that("can find Cordoba location", {
  # testthat::skip_if_offline()
  skip_on_cran()
  loc <- find_location("Cordoba")
  expect_true(length(loc) > 0)
})

test_that("no locations for wrong char", {
  # testthat::skip_if_offline()
  skip_on_cran()
  loc <- find_location("WrongLocation")
  expect_true(length(loc) == 0)
})
