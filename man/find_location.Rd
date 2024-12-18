% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find_location.R
\name{find_location}
\alias{find_location}
\title{Get location ID depending on a query term.}
\usage{
find_location(term, location_types = c())
}
\arguments{
\item{term}{searched term (for suggestions).}

\item{location_types}{list of desired location output, accepted values:
AIRPORT, AUTONOMOUS_TERRITORY, CITY, CONTINENT, COUNTRY, REGION, SUBDIVISION, TOURIST_REGION.}
}
\description{
Get location ID depending on a query term using the Kiwi API.
}
\examples{
\donttest{
cba_locs <- find_location("Cordoba", location_types = c("CITY", "REGION"))
}

}
