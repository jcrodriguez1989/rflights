#' Get location ID depending on a query term.
#'
#' Get location ID depending on a query term using the
#' [Kiwi API](https://docs.kiwi.com/).
#'
#' @param term searched term (for suggestions). This parameter expects a full
#' IATA code. If IATA code is not given, the search will go through other
#' available fields: ‘name’ or ‘code’ of the location. It also depends on the
#' ‘location_types’ specified eg. airport, city, country. The search that is
#' used behind the scenes is elasticsearch. It returns data based on relevancy
#' and many other factors.
#'
#' @param locale desired locale output - this is the language of the results.
#' Should any other locale be used other than the specified locales.
#'
#' @param location_types list of desired location output, accepted values:
#' station, airport, bus_station, city, autonomous_territory, subdivision,
#' country, region, continent.
#'
#' @importFrom httr GET content
#' @importFrom utils URLencode
#'
#' @export
#'
#' @examples
#' \donttest{
#' cba_locs <- find_location("Cordoba", location_types = c("city", "airport"))
#' # show some info of the found locations
#' lapply(cba_locs, function(act_loc) {
#'   c(act_loc$name, act_loc$country$name)
#' })
#' }
#'
find_location <- function(term, location_types = NA, locale = "en-US") {
  loc_types <- ""
  if (any(!is.na(location_types))) {
    loc_types <- sapply(location_types, URLencode)
    loc_types <- paste0("&location_types=", loc_types, collapse = "")
  }

  query_url <- paste0(
    endpoint, "locations?",
    "term=", URLencode(term),
    "&locale=", locale,
    loc_types
  )
  query_res <- GET(query_url)

  if (query_res$status_code != 200) {
    stop(paste(content(query_res)$message))
  }

  return(content(query_res)$locations)
}
