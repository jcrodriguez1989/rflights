#' Get location ID depending on a query term.
#'
#' Get location ID depending on a query term using the Kiwi API.
#'
#' @param term searched term (for suggestions).
#' @param location_types list of desired location output, accepted values:
#'   AIRPORT, AUTONOMOUS_TERRITORY, CITY, CONTINENT, COUNTRY, REGION, SUBDIVISION, TOURIST_REGION.
#'
#' @importFrom httr content content_type_json RETRY
#' @importFrom jsonlite toJSON
#'
#' @export
#'
#' @examples
#' \donttest{
#' cba_locs <- find_location("Cordoba", location_types = c("CITY", "REGION"))
#' }
#'
find_location <- function(term, location_types = c()) {
  if (length(location_types) == 0) {
    location_types <- c(
      "AIRPORT", "AUTONOMOUS_TERRITORY", "CITY", "CONTINENT", "COUNTRY", "REGION", "SUBDIVISION",
      "TOURIST_REGION"
    )
  }
  body <- list(
    query = umbrella_places_query,
    variables = list(
      search = list(term = term),
      filter = list(onlyTypes = location_types),
      options = list(locale = "en")
    )
  )
  locations <- RETRY(
    "POST",
    paste0(api_url, "?featureName=UmbrellaPlacesQuery"),
    body = toJSON(body, auto_unbox = TRUE, null = "null"),
    content_type_json(),
    encode = "json"
  )
  if (!locations$status_code %in% 200:299) {
    # If there was an API error, then return the response object.
    return(locations)
  }
  locations <- content(locations, as = "parsed", simplifyVector = TRUE)
  locations <- locations$data$places$edges
  if (is.data.frame(locations$node)) {
    colnames(locations$node) <- gsub("[^a-zA-Z]", "", colnames(locations$node))
  }
  return(locations)
}
