context("get_flights")

test_that("can find flights", {
  skip_if_offline()
  skip_on_cran()
  flights <- get_flights("City:cordoba_cd_ar", "City:mendoza_md_ar")
  expect_true(nrow(flights$itineraries) > 0)
})

test_that("no flights for wrong location", {
  skip_if_offline()
  skip_on_cran()
  flights <- get_flights("WrongLocation")
  expect_false(is.data.frame(flights$itineraries))
})
