R Flights
================

Query plane tickets, from several airlines, using the Kiwi API. The API
is documented at <https://docs.kiwi.com/>.

## Installation

`rflights` is currently only available as a GitHub package.

To install it run the following from an R console:

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

    ## [1] 91

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
    ## [27] "has_airport_change"            "fly_duration"                 
    ## [29] "duration"                      "hashtags"                     
    ## [31] "facilitated_booking_available" "conversion"                   
    ## [33] "booking_token"                 "quality"                      
    ## [35] "found_on"

``` r
sapply(flights, function(x) x$price)
```

    ##  [1]  456  469  469  500  504  504  504  506  506  506  506  507  508  509
    ## [15]  510  512  513  512  515  515  515  516  516  517  518  521  520  522
    ## [29]  522  522  521  521  521  521  523  522  523  523  523  524  523  523
    ## [43]  523  523  524  524  524  525  524  525  525  525  524  525  524  526
    ## [57]  526  526  527  528  529  529  529  530  531  531  531  530  531  531
    ## [71]  532  531  531  532  531  532  533  533  535  534  535  536  536  536
    ## [85]  536  536  537  537  538  548 1417

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

    ## [1] 162

``` r
t(sapply(flights, function(x) c(x$price, x$cityTo)))
```

    ##        [,1]  [,2]                   
    ##   [1,] "26"  "Salta"                
    ##   [2,] "26"  "Salta"                
    ##   [3,] "26"  "Salta"                
    ##   [4,] "26"  "Salta"                
    ##   [5,] "26"  "Salta"                
    ##   [6,] "26"  "Salta"                
    ##   [7,] "29"  "San Miguel de Tucumán"
    ##   [8,] "29"  "San Miguel de Tucumán"
    ##   [9,] "29"  "Corrientes"           
    ##  [10,] "29"  "Corrientes"           
    ##  [11,] "32"  "Neuquén"              
    ##  [12,] "32"  "Neuquén"              
    ##  [13,] "32"  "Neuquén"              
    ##  [14,] "32"  "Neuquén"              
    ##  [15,] "32"  "Neuquén"              
    ##  [16,] "34"  "San Miguel de Tucumán"
    ##  [17,] "34"  "San Miguel de Tucumán"
    ##  [18,] "35"  "Buenos Aires"         
    ##  [19,] "35"  "Buenos Aires"         
    ##  [20,] "35"  "Buenos Aires"         
    ##  [21,] "35"  "Buenos Aires"         
    ##  [22,] "35"  "Buenos Aires"         
    ##  [23,] "35"  "Buenos Aires"         
    ##  [24,] "35"  "Buenos Aires"         
    ##  [25,] "35"  "Buenos Aires"         
    ##  [26,] "35"  "Buenos Aires"         
    ##  [27,] "35"  "Buenos Aires"         
    ##  [28,] "35"  "Buenos Aires"         
    ##  [29,] "35"  "Buenos Aires"         
    ##  [30,] "35"  "Buenos Aires"         
    ##  [31,] "35"  "Buenos Aires"         
    ##  [32,] "35"  "Buenos Aires"         
    ##  [33,] "35"  "Buenos Aires"         
    ##  [34,] "35"  "Buenos Aires"         
    ##  [35,] "35"  "Buenos Aires"         
    ##  [36,] "35"  "Buenos Aires"         
    ##  [37,] "35"  "Buenos Aires"         
    ##  [38,] "35"  "Buenos Aires"         
    ##  [39,] "35"  "Buenos Aires"         
    ##  [40,] "35"  "Buenos Aires"         
    ##  [41,] "35"  "Buenos Aires"         
    ##  [42,] "35"  "Buenos Aires"         
    ##  [43,] "35"  "Buenos Aires"         
    ##  [44,] "35"  "Buenos Aires"         
    ##  [45,] "35"  "Buenos Aires"         
    ##  [46,] "35"  "Buenos Aires"         
    ##  [47,] "35"  "Buenos Aires"         
    ##  [48,] "35"  "Buenos Aires"         
    ##  [49,] "35"  "Buenos Aires"         
    ##  [50,] "35"  "Buenos Aires"         
    ##  [51,] "35"  "Buenos Aires"         
    ##  [52,] "35"  "Buenos Aires"         
    ##  [53,] "35"  "Buenos Aires"         
    ##  [54,] "35"  "Buenos Aires"         
    ##  [55,] "35"  "Buenos Aires"         
    ##  [56,] "35"  "Buenos Aires"         
    ##  [57,] "35"  "Buenos Aires"         
    ##  [58,] "35"  "Buenos Aires"         
    ##  [59,] "35"  "Buenos Aires"         
    ##  [60,] "36"  "Puerto Iguazú"        
    ##  [61,] "36"  "Puerto Iguazú"        
    ##  [62,] "37"  "Buenos Aires"         
    ##  [63,] "37"  "Buenos Aires"         
    ##  [64,] "37"  "Buenos Aires"         
    ##  [65,] "37"  "Buenos Aires"         
    ##  [66,] "37"  "Buenos Aires"         
    ##  [67,] "37"  "Buenos Aires"         
    ##  [68,] "37"  "Buenos Aires"         
    ##  [69,] "37"  "Buenos Aires"         
    ##  [70,] "37"  "Buenos Aires"         
    ##  [71,] "37"  "Buenos Aires"         
    ##  [72,] "37"  "Buenos Aires"         
    ##  [73,] "37"  "Buenos Aires"         
    ##  [74,] "37"  "Buenos Aires"         
    ##  [75,] "37"  "Buenos Aires"         
    ##  [76,] "37"  "Buenos Aires"         
    ##  [77,] "37"  "Buenos Aires"         
    ##  [78,] "37"  "Buenos Aires"         
    ##  [79,] "37"  "Buenos Aires"         
    ##  [80,] "37"  "Buenos Aires"         
    ##  [81,] "37"  "Buenos Aires"         
    ##  [82,] "37"  "Buenos Aires"         
    ##  [83,] "37"  "Buenos Aires"         
    ##  [84,] "37"  "Buenos Aires"         
    ##  [85,] "38"  "Corrientes"           
    ##  [86,] "38"  "Corrientes"           
    ##  [87,] "40"  "Buenos Aires"         
    ##  [88,] "41"  "Buenos Aires"         
    ##  [89,] "41"  "Buenos Aires"         
    ##  [90,] "41"  "Buenos Aires"         
    ##  [91,] "41"  "Buenos Aires"         
    ##  [92,] "41"  "Buenos Aires"         
    ##  [93,] "41"  "Buenos Aires"         
    ##  [94,] "41"  "Buenos Aires"         
    ##  [95,] "40"  "Salta"                
    ##  [96,] "42"  "San Miguel de Tucumán"
    ##  [97,] "41"  "Neuquén"              
    ##  [98,] "42"  "Buenos Aires"         
    ##  [99,] "42"  "Buenos Aires"         
    ## [100,] "42"  "Buenos Aires"         
    ## [101,] "42"  "Buenos Aires"         
    ## [102,] "45"  "Neuquén"              
    ## [103,] "46"  "Buenos Aires"         
    ## [104,] "46"  "Buenos Aires"         
    ## [105,] "46"  "Buenos Aires"         
    ## [106,] "46"  "Buenos Aires"         
    ## [107,] "46"  "Buenos Aires"         
    ## [108,] "46"  "Buenos Aires"         
    ## [109,] "46"  "Buenos Aires"         
    ## [110,] "46"  "Buenos Aires"         
    ## [111,] "46"  "Buenos Aires"         
    ## [112,] "46"  "Buenos Aires"         
    ## [113,] "46"  "Buenos Aires"         
    ## [114,] "46"  "Buenos Aires"         
    ## [115,] "46"  "Buenos Aires"         
    ## [116,] "46"  "Buenos Aires"         
    ## [117,] "46"  "Buenos Aires"         
    ## [118,] "46"  "Buenos Aires"         
    ## [119,] "46"  "Buenos Aires"         
    ## [120,] "46"  "Buenos Aires"         
    ## [121,] "46"  "Buenos Aires"         
    ## [122,] "46"  "Buenos Aires"         
    ## [123,] "46"  "Buenos Aires"         
    ## [124,] "46"  "Buenos Aires"         
    ## [125,] "46"  "Buenos Aires"         
    ## [126,] "46"  "Buenos Aires"         
    ## [127,] "46"  "Buenos Aires"         
    ## [128,] "46"  "Buenos Aires"         
    ## [129,] "46"  "Buenos Aires"         
    ## [130,] "46"  "Buenos Aires"         
    ## [131,] "46"  "Buenos Aires"         
    ## [132,] "46"  "Buenos Aires"         
    ## [133,] "46"  "Buenos Aires"         
    ## [134,] "46"  "Buenos Aires"         
    ## [135,] "46"  "Buenos Aires"         
    ## [136,] "46"  "Buenos Aires"         
    ## [137,] "46"  "Buenos Aires"         
    ## [138,] "46"  "Buenos Aires"         
    ## [139,] "47"  "Salta"                
    ## [140,] "47"  "Buenos Aires"         
    ## [141,] "75"  "Puerto Iguazú"        
    ## [142,] "86"  "Puerto Iguazú"        
    ## [143,] "86"  "Puerto Iguazú"        
    ## [144,] "132" "Puerto Iguazú"        
    ## [145,] "214" "Buenos Aires"         
    ## [146,] "214" "Buenos Aires"         
    ## [147,] "214" "Buenos Aires"         
    ## [148,] "214" "Buenos Aires"         
    ## [149,] "214" "Buenos Aires"         
    ## [150,] "214" "Buenos Aires"         
    ## [151,] "214" "Buenos Aires"         
    ## [152,] "214" "Buenos Aires"         
    ## [153,] "215" "Buenos Aires"         
    ## [154,] "215" "Buenos Aires"         
    ## [155,] "239" "Buenos Aires"         
    ## [156,] "239" "Buenos Aires"         
    ## [157,] "239" "Buenos Aires"         
    ## [158,] "239" "Buenos Aires"         
    ## [159,] "239" "Buenos Aires"         
    ## [160,] "239" "Buenos Aires"         
    ## [161,] "239" "Buenos Aires"         
    ## [162,] "239" "Buenos Aires"
