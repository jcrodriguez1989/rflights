R Flights
================

[![CRAN
status](https://www.r-pkg.org/badges/version/rflights)](https://CRAN.R-project.org/package=rflights)
[![CRAN
logs](https://cranlogs.r-pkg.org/badges/rflights)](https://cran.r-project.org/package=rflights)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![Travis build
status](https://travis-ci.org/jcrodriguez1989/rflights.svg?branch=master)](https://travis-ci.org/jcrodriguez1989/rflights)
[![Coverage
status](https://codecov.io/gh/jcrodriguez1989/rflights/branch/master/graph/badge.svg)](https://codecov.io/github/jcrodriguez1989/rflights?branch=master)

Query plane tickets, from several airlines, using the Kiwi API (similar
to Google Flights).

The API is documented at <https://docs.kiwi.com/>.

## Installation

You can install the `rflights` package from CRAN:

``` r
install.packages("rflights")
```

Or get the latest version from GitHub:

``` r
if (!require("remotes")) {
  install.packages("remotes")
}
remotes::install_github("jcrodriguez1989/rflights")
```

## Usage

### Get city or country IDs

``` r
library("rflights")
# get Argentina and toulouse IDs
arg_id <- find_location("Argentina", "COUNTRY")$node
nrow(arg_id) # only one result, so it might be the one
```

    ## [1] 1

``` r
colnames(arg_id)
```

    ##  [1] "typename" "isPlace"  "id"       "legacyId" "name"     "slug"    
    ##  [7] "slugEn"   "gps"      "rank"     "code"     "region"

``` r
arg_id$id
```

    ## [1] "Country:AR"

``` r
arg_id$region$continent$id
```

    ## [1] "Continent:south-america"

``` r
arg_id <- arg_id$id

tl_id <- find_location("toulouse")$node
nrow(tl_id)
```

    ## [1] 3

``` r
tl_id$typename
```

    ## [1] "City"          "Station"       "TouristRegion"

``` r
# we are looking for the city
tl_id <- tl_id[tl_id$typename == "City", ]
tl_id$country$name
```

    ## [1] "France"

``` r
tl_id <- tl_id$id
```

### Get flight prices

``` r
# get flights from Argentina to toulouse for this month
flights <- get_flights(
  fly_from = "Country:AR", fly_to = "City:toulouse_fr",
  departure_from = Sys.Date(), departure_to = Sys.Date() + 30
)
nrow(flights$itineraries)
head(flights$itineraries$price$amount)
```

### Fly to anywhere

Find plane tickets from my city to anywhere, from today to 2 next weeks.

``` r
# I am a nomad, let's go anywhere!
flights <- search_flights(
  fly_from = "Country:AR",
  departure_from = Sys.Date(), departure_to = Sys.Date() + 2 * 7
)
nrow(flights$itineraries)
```

    ## [1] 53

``` r
head(data.frame(
  from = flights$itineraries$source$station$name, to = flights$itineraries$destination$station$name,
  price = flights$itineraries$price$amount
))
```

    ##                                                          from
    ## 1                            Ministro Pistarini International
    ## 2                            Ministro Pistarini International
    ## 3                            Ministro Pistarini International
    ## 4 Ingeniero Aeronáutico Ambrosio L.V. Taravella International
    ## 5                            Ministro Pistarini International
    ## 6                            Ministro Pistarini International
    ##                              to price
    ## 1 John F. Kennedy International   414
    ## 2                       Gatwick   559
    ## 3             Barcelona–El Prat   554
    ## 4  Adolfo Suárez Madrid–Barajas   462
    ## 5          Narita International   832
    ## 6     Charles de Gaulle Airport   560
