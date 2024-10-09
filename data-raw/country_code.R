# Find locations.
country_code <- purrr::map_dfr(
  sort(unique(countrycode::codelist_panel$country.name.en)), function(country) {
    logger::log_info(country)
    rflights::find_location(gsub("[^a-zA-Z]", "", country), "COUNTRY")$node
  }
)

country_code <- dplyr::mutate(
  country_code, name,
  code = id, continent = gsub("Continent:", "", region$continent$id), .keep = "none"
)

# add data.frame to package
usethis::use_data(country_code, overwrite = TRUE)
