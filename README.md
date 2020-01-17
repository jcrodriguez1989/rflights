R Flights
================

[![Travis build
status](https://travis-ci.org/jcrodriguez1989/rflights.svg?branch=master)](https://travis-ci.org/jcrodriguez1989/rflights)
[![Coverage
status](https://codecov.io/gh/jcrodriguez1989/rflights/branch/master/graph/badge.svg)](https://codecov.io/github/jcrodriguez1989/rflights?branch=master)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)

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
arg_id <- find_location("Argentina", "country")
length(arg_id) # only one result, so it might be the one
```

    ## [1] 1

``` r
arg_id <- arg_id[[1]]
names(arg_id)
```

    ##  [1] "id"                "active"            "code"             
    ##  [4] "code_alpha_3"      "name"              "slug"             
    ##  [7] "alternative_names" "rank"              "global_rank_dst"  
    ## [10] "neighbours"        "organizations"     "currency"         
    ## [13] "region"            "continent"         "location"         
    ## [16] "type"

``` r
arg_id$id
```

    ## [1] "AR"

``` r
arg_id$continent
```

    ## $id
    ## [1] "south-america"
    ## 
    ## $code
    ## [1] "SA"
    ## 
    ## $name
    ## [1] "South America"
    ## 
    ## $slug
    ## [1] "south-america"

``` r
arg_id <- arg_id$id

tl_id <- find_location("toulouse")
length(tl_id)
```

    ## [1] 5

``` r
lapply(tl_id, function(x) x$type)
```

    ## [[1]]
    ## [1] "city"
    ## 
    ## [[2]]
    ## [1] "airport"
    ## 
    ## [[3]]
    ## [1] "bus_station"
    ## 
    ## [[4]]
    ## [1] "tourist_region"
    ## 
    ## [[5]]
    ## [1] "bus_station"

``` r
# we are looking for the city
tl_id <- tl_id[[which(sapply(tl_id, function(x) x$type == "city"))]]
tl_id$country
```

    ## $id
    ## [1] "FR"
    ## 
    ## $name
    ## [1] "France"
    ## 
    ## $slug
    ## [1] "france"
    ## 
    ## $code
    ## [1] "FR"

``` r
tl_id <- tl_id$id
tl_id
```

    ## [1] "toulouse_fr"

### Get flight prices

``` r
# get flights from Argentina to toulouse around 01 July to 09 July
# Maybe I can go to the user2019??
flights <- get_flights(
  fly_from = "AR", fly_to = "toulouse_fr",
  date_from = "01/09/2019", date_to = "09/09/2019"
)
length(flights)
names(flights[[1]])
sapply(flights, function(x) x$price)
```

## Examples

### Create flight price alarms

I used it to alert through a [Pushbullet](https://www.pushbullet.com/)
message.

``` r
my_savings <- 25 # yup, just 25USD
found_ticket <- FALSE
while (!found_ticket) {
  flights <- get_flights(
    fly_from = "AR", fly_to = "toulouse_fr",
    date_from = "01/09/2019", date_to = "09/09/2019"
  )
  flights <- flights[sapply(flights, function(x) x$price) <= my_savings]
  if (length(flights) > 0) {
    send_alert(paste0(
      "There is a plane ticket you can afford!\n",
      "Check it out at Kiwi.com"
    ))
    # user-defined alert function (not in rflights)
  }
}
```

### Fly to anywhere

Find plane tickets from my city to anywhere, from today to 2 next weeks.

``` r
# I am a freelancer, let's go anywhere!
flights <- get_flights(
  fly_from = "GNV",
  date_from = Sys.Date(), date_to = Sys.Date() + 2 * 7
)
length(flights)
```

    ## [1] 226

``` r
head(t(sapply(flights, function(x) c(x$price, x$cityTo))), n = 20)
```

    ##       [,1]  [,2]       
    ##  [1,] "146" "New York" 
    ##  [2,] "146" "New York" 
    ##  [3,] "149" "New York" 
    ##  [4,] "149" "New York" 
    ##  [5,] "165" "New York" 
    ##  [6,] "165" "New York" 
    ##  [7,] "165" "New York" 
    ##  [8,] "166" "New York" 
    ##  [9,] "167" "New York" 
    ## [10,] "167" "New York" 
    ## [11,] "167" "Orlando"  
    ## [12,] "168" "Orlando"  
    ## [13,] "171" "Orlando"  
    ## [14,] "171" "Orlando"  
    ## [15,] "171" "Orlando"  
    ## [16,] "171" "Orlando"  
    ## [17,] "173" "New York" 
    ## [18,] "173" "Orlando"  
    ## [19,] "173" "Las Vegas"
    ## [20,] "174" "New York"
