#' Query flight prices.
#'
#' Query flight prices using the [Kiwi API](https://docs.kiwi.com/).
#'
#' @param fly_from ID of the departure location.
#' It accepts multiple values separated by comma, these values might be airport
#' codes, city IDs, two letter country codes, metropolitan codes and radiuses as
#' well as subdivision, region, autonomous_territory, continent and specials
#' (Points of interest, such as Times Square).
#' Some locations have the same code for airport and metropolis (city), e.g.
#' DUS stands for metro code Duesseldorf, Moenchengladbach and Weeze as well as
#' Duesseldorf airport. See the following examples:
#' fly_from=city:DUS will match all airports in "DUS", "MGL" and "NRN" (all in
#' the city of Duesseldorf)
#' fly_from=DUS will do the same as the above
#' fly_from=airport:DUS will only match airport "DUS" Radius needs to be in form
#' lat-lon-xkm. The number of decimal places for radius is limited to 6.
#' E.g.-23.24--47.86-500km for places around Sao Paulo. 'LON' - checks every
#' airport in London, 'LHR' - checks flights from London Heathrow, 'UK' -
#' flights from the United Kingdom. Link to Locations API.
#'
#' @param fly_to ID of the arrival destination.
#' It accepts the same values in the same format as the fly_from parameter.
#'
#' @param date_from search flights from this date (dd/mm/YYYY). Use parameters
#' date_from and date_to as a date range for the flight departure.
#' Parameters 'date_from=01/05/2016' and 'date_to=30/05/2016' mean that the
#' departure can be anytime between the specified dates. For the dates of the
#' return flights, use the 'return_to' and 'return_from' or 'nights_in_dst_from'
#' and 'nights_in_dst_to' parameters.
#'
#' @param date_to search flights upto this date (dd/mm/YYYY).
#'
#' @param return_from min return date of the whole trip (dd/mm/YYYY).
#'
#' @param return_to max return date of the whole trip (dd/mm/YYYY).
#'
#' @param curr use this parameter to change the currency in the response.
#'
#' @param price_from result filter, minimal price
#'
#' @param price_to result filter, maximal price
#'
#' @param other_params named list of other params from
#' https://docs.kiwi.com/#flights-flights-get
#'
#' @importFrom httr GET content
#' @importFrom methods is
#' @importFrom utils URLencode
#'
#' @export
#'
#' @examples
#' \donttest{
#' # get Argentina and toulouse IDs
#' arg_id <- find_location("Argentina", "country")[[1]]$id # AR
#' tl_id <- find_location("toulouse", "city")[[1]]$id
#'
#' # get flights with no specified date
#' flights <- get_flights(arg_id, tl_id)
#' sapply(flights, function(x) x$price)
#' }
#'
get_flights <- function(fly_from, fly_to = "anywhere",
                        date_from = Sys.Date(), date_to = date_from + 1,
                        return_from = NA, return_to = NA,
                        curr = "USD", price_from = NA, price_to = NA,
                        other_params = list()) {
  if (is(date_to, "Date"))
    date_to <- as.character(date_to, format = "%d/%m/%Y")
  if (is(date_from, "Date"))
    date_from <- as.character(date_from, format = "%d/%m/%Y")

  if (!is.na(return_from)) {
    return_from <- as.character(return_from, format = "%d/%m/%Y")
  }
  if (!is.na(return_to)) {
    return_to <- as.character(return_to, format = "%d/%m/%Y")
  }

  # in the case fly_* are vectors
  fly_from <- paste(fly_from, collapse = ",")
  fly_to <- paste(fly_to, collapse = ",")

  query_url <- paste0(
    endpoint, "flights?",
    "partner=picky",
    "&fly_from=", URLencode(fly_from),
    "&fly_to=", URLencode(fly_to),
    "&date_from=", date_from,
    "&date_to=", date_to,
    ifelse(is.na(return_from), "", paste0("&return_from=", return_from)),
    ifelse(is.na(return_to), "", paste0("&return_to=", return_to)),
    "&curr=", curr,
    ifelse(is.na(price_from), "", paste0("&price_from=", price_from)),
    ifelse(is.na(price_to), "", paste0("&price_to=", price_to)),
    paste0(lapply(names(other_params), function(x) paste0(
        "&", x, "=", other_params[[x]]
      )), collapse = "")
  )
  query_res <- GET(query_url)

  if (query_res$status_code != 200) {
    stop(paste(content(query_res)$message))
  }

  return(content(query_res)$data)
}
