#' Query flight prices.
#'
#' Query flight prices using the Kiwi API.
#'
#' @param fly_from a vector of IDs of the departure locations. E.g.,
#'   `c("City:cordoba_cd_ar", "City:mendoza_md_ar")`.
#' @param fly_to a vector of IDs of the arrival destinations.
#' @param departure_from search flights from this datetime. If `NULL`, anytime.
#' @param departure_to search flights up to this datetime. If `NULL`, anytime.
#' @param sort_by one of "POPULARITY", "PRICE", or "QUALITY".
#' @param passengers If `NULL`, it will use the default: `list(adults = 1, children = 0,`
#'   `infants = 0, adultsHoldBags = 0, adultsHandBags = 0, childrenHoldBags = list(),`
#'   `childrenHandBags = list())`.
#' @param cabin_class If `NULL`, it will use the default: `list(cabinClass = "ECONOMY",`
#'   `applyMixedClasses = FALSE)`.
#'
#' @importFrom httr content content_type_json RETRY
#' @importFrom jsonlite toJSON
#'
#' @export
#'
search_flights <- function(fly_from, fly_to = "anywhere", departure_from = NULL,
                           departure_to = NULL, sort_by = "POPULARITY", passengers = NULL,
                           cabin_class = NULL) {
  if (is.null(passengers)) {
    passengers <- list(
      adults = 1, children = 0, infants = 0, adultsHoldBags = 0, adultsHandBags = 0,
      childrenHoldBags = list(), childrenHandBags = list()
    )
  }
  if (is.null(cabin_class)) {
    cabin_class <- list(cabinClass = "ECONOMY", applyMixedClasses = FALSE)
  }
  body <- list(
    query = one_per_city_one_way_itineraries_query,
    variables = list(
      search = list(
        itinerary = list(
          source = list(ids = fly_from),
          destination = list(ids = fly_to)
        ),
        passengers = passengers,
        cabinClass = cabin_class
      ),
      filter = list(
        allowChangeInboundDestination = TRUE,
        allowChangeInboundSource = TRUE,
        allowDifferentStationConnection = TRUE,
        allowReturnFromDifferentCity = FALSE,
        allowReturnToDifferentCity = FALSE,
        enableSelfTransfer = TRUE,
        enableThrowAwayTicketing = TRUE,
        enableTrueHiddenCity = TRUE,
        transportTypes = c("FLIGHT"),
        contentProviders = c("KIWI"),
        limit = 1000
      ),
      options = list(
        sortBy = sort_by,
        mergePriceDiffRule = "INCREASED",
        currency = "usd",
        apiUrl = NULL,
        locale = "en",
        # market = "ar",
        partner = "skypicker",
        # partnerMarket = "ar",
        affilID = "skypicker",
        storeSearch = FALSE,
        searchStrategy = "REDUCED"
      )
    )
  )
  if (!is.null(departure_from) && !is.null(departure_to)) {
    body$variables$search$itinerary$outboundDepartureDate <- list(
      start = format(departure_from, "%Y-%m-%dT%H:%M:%S"),
      end = format(departure_to, "%Y-%m-%dT%H:%M:%S")
    )
  }
  flights <- RETRY(
    "POST",
    paste0(api_url, "?featureName=OnePerCityOneWayItinerariesQuery"),
    body = toJSON(body, auto_unbox = TRUE, null = "null"),
    content_type_json(),
    encode = "json"
  )
  if (!flights$status_code %in% 200:299) {
    # If there was an API error, then return the response object.
    return(flights)
  }
  flights <- content(flights, as = "parsed", simplifyVector = TRUE)
  flights <- flights$data$onewayOnePerCityItineraries
  if (is.data.frame(flights$itineraries)) {
    colnames(flights$itineraries) <- gsub("[^a-zA-Z]", "", colnames(flights$itineraries))
  }
  return(flights)
}
