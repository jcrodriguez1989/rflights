library("rflights")
library("usethis")

country_code <- rflights::country_code
by_continent <- by(country_code$code, country_code$continent, identity)
africa <- as.character(by_continent[["Africa"]])
asia <- as.character(by_continent[["Asia"]])
europe <- as.character(by_continent[["Europe"]])
north_america <- as.character(by_continent[["North America"]])
oceania <- as.character(by_continent[["Oceania"]])
south_america <- as.character(by_continent[["South America"]])

# add data.frame to package
usethis::use_data(africa, overwrite = TRUE)
usethis::use_data(asia, overwrite = TRUE)
usethis::use_data(europe, overwrite = TRUE)
usethis::use_data(north_america, overwrite = TRUE)
usethis::use_data(oceania, overwrite = TRUE)
usethis::use_data(south_america, overwrite = TRUE)
