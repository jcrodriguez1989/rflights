context("search_flights")

test_that("can find flights", {
  skip_if_offline()
  skip_on_cran()
  flights <- search_flights(asia[[1]], oceania[[1]])
  expect_true(nrow(flights$itineraries) > 0)
})

test_that("no flights for wrong location", {
  skip_if_offline()
  skip_on_cran()
  flights <- search_flights("WrongLocation")
  expect_false(is.data.frame(flights$itineraries))
})
