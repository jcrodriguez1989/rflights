library("countrycode")
library("rflights")
library("usethis")

locs <- lapply(
  unique(countrycode::codelist_panel$country.name.en),
  function(x) find_location(x, "country")
)
locs <- unlist(locs, recursive = FALSE)

country_code <- data.frame(t(sapply(
  locs,
  function(act_loc) {
    c(
      slug = act_loc[["slug"]], name = act_loc[["name"]],
      code = act_loc[["code"]], continent = act_loc$continent$name
    )
  }
)))
country_code <- unique(country_code)
rownames(country_code) <- country_code$slug
country_code <- country_code[, -1]
country_code <- country_code[order(country_code$name), ]

# add data.frame to package
usethis::use_data(country_code, overwrite = TRUE)
