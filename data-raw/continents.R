country_code <- rflights::country_code
by_continent <- by(country_code$code, country_code$continent, identity)
africa <- as.character(by_continent[["africa"]])
asia <- as.character(by_continent[["asia"]])
europe <- as.character(by_continent[["europe"]])
north_america <- as.character(by_continent[["north-america"]])
oceania <- as.character(by_continent[["oceania"]])
south_america <- as.character(by_continent[["south-america"]])

# add data.frame to package
usethis::use_data(africa, overwrite = TRUE)
usethis::use_data(asia, overwrite = TRUE)
usethis::use_data(europe, overwrite = TRUE)
usethis::use_data(north_america, overwrite = TRUE)
usethis::use_data(oceania, overwrite = TRUE)
usethis::use_data(south_america, overwrite = TRUE)
