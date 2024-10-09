umbrella_places_query <- "
  query UmbrellaPlacesQuery(
    $search: PlacesSearchInput
    $filter: PlacesFilterInput
    $options: PlacesOptionsInput
  ) {
    places(search: $search, filter: $filter, options: $options, first: 20) {
      __typename
      ... on AppError {
        error: message
      }
      ... on PlaceConnection {
        edges {
          rank
          distance {
            __typename
            distance
          }
          isAmbiguous
          node {
            __typename
            __isPlace: __typename
            id
            legacyId
            name
            slug
            slugEn
            gps {
              lat
              lng
            }
            rank
            ... on City {
              code
              autonomousTerritory {
                legacyId
                id
              }
              subdivision {
                legacyId
                name
                id
              }
              country {
                legacyId
                name
                slugEn
                region {
                  legacyId
                  continent {
                    legacyId
                    id
                  }
                  id
                }
                id
              }
              airportsCount
              groundStationsCount
            }
            ... on Station {
              type
              code
              gps {
                lat
                lng
              }
              city {
                legacyId
                name
                slug
                autonomousTerritory {
                  legacyId
                  id
                }
                subdivision {
                  legacyId
                  name
                  id
                }
                country {
                  legacyId
                  name
                  region {
                    legacyId
                    continent {
                      legacyId
                      id
                    }
                    id
                  }
                  id
                }
                id
              }
            }
            ... on Region {
              continent {
                legacyId
                id
              }
            }
            ... on Country {
              code
              region {
                legacyId
                continent {
                  legacyId
                  id
                }
                id
              }
            }
            ... on AutonomousTerritory {
              country {
                legacyId
                name
                region {
                  legacyId
                  continent {
                    legacyId
                    id
                  }
                  id
                }
                id
              }
            }
            ... on Subdivision {
              country {
                legacyId
                name
                region {
                  legacyId
                  continent {
                    legacyId
                    id
                  }
                  id
                }
                id
              }
            }
          }
        }
      }
    }
  }
"
