R Flights
================

[![Travis build
status](https://travis-ci.org/jcrodriguez1989/rflights.svg?branch=master)](https://travis-ci.org/jcrodriguez1989/rflights)
[![Coverage
status](https://codecov.io/gh/jcrodriguez1989/rflights/branch/master/graph/badge.svg)](https://codecov.io/github/jcrodriguez1989/rflights?branch=master)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

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
if (!require("remotes"))
  install.packages("remotes")
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
    ##  [4] "name"              "slug"              "alternative_names"
    ##  [7] "rank"              "global_rank_dst"   "neighbours"       
    ## [10] "organizations"     "currency"          "region"           
    ## [13] "continent"         "location"          "type"

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

    ## [1] 4

``` r
lapply(tl_id, function (x) x$type)
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

``` r
# we are looking for the city
tl_id <- tl_id[[which(sapply(tl_id, function (x) x$type == "city"))]]
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
# Maybe I can go to the user2019 🤔??
flights <- get_flights(fly_from = "AR", fly_to = "toulouse_fr",
                       date_from = "01/09/2019", date_to = "09/09/2019")
length(flights)
```

    ## [1] 99

``` r
names(flights[[1]])
```

    ##  [1] "id"                            "countryFrom"                  
    ##  [3] "countryTo"                     "bags_price"                   
    ##  [5] "baglimit"                      "dTime"                        
    ##  [7] "aTime"                         "dTimeUTC"                     
    ##  [9] "p1"                            "p2"                           
    ## [11] "p3"                            "aTimeUTC"                     
    ## [13] "price"                         "flyFrom"                      
    ## [15] "mapIdfrom"                     "mapIdto"                      
    ## [17] "flyTo"                         "distance"                     
    ## [19] "cityFrom"                      "cityTo"                       
    ## [21] "route"                         "routes"                       
    ## [23] "airlines"                      "nightsInDest"                 
    ## [25] "pnr_count"                     "transfers"                    
    ## [27] "has_airport_change"            "virtual_interlining"          
    ## [29] "fly_duration"                  "duration"                     
    ## [31] "hashtags"                      "facilitated_booking_available"
    ## [33] "conversion"                    "booking_token"                
    ## [35] "quality"                       "found_on"

``` r
sapply(flights, function(x) x$price)
```

    ##  [1] 455 472 498 500 500 503 503 502 506 507 507 508 509 510 509 512 512
    ## [18] 513 512 513 513 515 516 516 517 517 518 520 520 522 522 521 523 522
    ## [35] 522 523 524 525 525 525 526 526 526 527 527 529 529 529 530 530 531
    ## [52] 531 531 532 532 532 533 533 533 533 534 536 535 536 537 536 538 538
    ## [69] 539 539 540 539 540 539 539 539 541 541 540 540 541 540 540 540 541
    ## [86] 541 542 541 543 543 542 543 543 543 543 544 544 606 675

## Examples

### Create flight price alarms

I used it to alert through a [Pushbullet](https://www.pushbullet.com/)
message.

``` r
my_savings <- 25 # yup, just 25USD 😣
found_ticket <- FALSE
while (!found_ticket) {
  flights <- get_flights(fly_from = "AR", fly_to = "toulouse_fr",
                         date_from = "01/09/2019", date_to = "09/09/2019")
  flights <- flights[sapply(flights, function(x) x$price) <= my_savings]
  if (length(flights) > 0) {
    send_alert(paste0(
      "There is a plane ticket you can afford!\n",
      "Check it out at Kiwi.com"))
    # user-defined alert function (not in rflights)
  }
}
```

### Fly to anywhere

Find plane tickets from my city to anywhere, from today to 2 next weeks.

``` r
# I am a freelancer, let's go anywhere!
flights <- get_flights(fly_from = "COR",
                       date_from = Sys.Date(), date_to = Sys.Date()+2*7)
length(flights)
```

    ## [1] 177

``` r
head(t(sapply(flights, function(x) c(x$price, x$cityTo))), n = 20)
```

    ##       [,1] [,2]                   
    ##  [1,] "26" "Salta"                
    ##  [2,] "26" "Salta"                
    ##  [3,] "26" "Salta"                
    ##  [4,] "29" "San Miguel de Tucumán"
    ##  [5,] "29" "San Miguel de Tucumán"
    ##  [6,] "29" "San Miguel de Tucumán"
    ##  [7,] "29" "San Miguel de Tucumán"
    ##  [8,] "29" "Buenos Aires"         
    ##  [9,] "29" "Buenos Aires"         
    ## [10,] "29" "Buenos Aires"         
    ## [11,] "29" "Buenos Aires"         
    ## [12,] "29" "Buenos Aires"         
    ## [13,] "29" "Buenos Aires"         
    ## [14,] "29" "Buenos Aires"         
    ## [15,] "29" "Buenos Aires"         
    ## [16,] "29" "Buenos Aires"         
    ## [17,] "29" "Buenos Aires"         
    ## [18,] "29" "Buenos Aires"         
    ## [19,] "29" "Corrientes"           
    ## [20,] "31" "Buenos Aires"
