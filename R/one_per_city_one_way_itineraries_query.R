one_per_city_one_way_itineraries_query <- "
  query OnePerCityOneWayItinerariesQuery(
    $search: SearchOnewayInput
    $filter: ItinerariesFilterInput
    $options: ItinerariesOptionsInput
  ) {
    onewayOnePerCityItineraries(search: $search, filter: $filter, options: $options) {
      __typename
      ... on AppError {
        error: message
      }
      ... on OnePerCityItineraries {
        itineraries {
          __typename
          ... on OnewayOnePerCityItinerary {
            ... on OnePerCityItinerary {
              __isOnePerCityItinerary: __typename
              __typename
              price {
                amount
                priceBeforeDiscount
              }
              priceEur {
                amount
              }
              source {
                station {
                  id
                  legacyId
                  name
                  city {
                    ... on Place {
                      __isPlace: __typename
                      __typename
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
                    id
                  }
                  country {
                    legacyId
                    code
                    name
                    id
                  }
                  gps {
                    lat
                    lng
                  }
                }
                localTime
                utcTime
              }
              destination {
                station {
                  id
                  legacyId
                  name
                  city {
                    ... on Place {
                      __isPlace: __typename
                      __typename
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
                    id
                  }
                  country {
                    legacyId
                    code
                    name
                    id
                  }
                  gps {
                    lat
                    lng
                  }
                }
                localTime
                utcTime
              }
            }
          }
        }
        metadata {
          itinerariesCount
          tilesDataSource
          statusPerProvider {
            provider {
              id
            }
            errorHappened
          }
          ...WeekDaysFilter_data
          ...useSortingModes_data
        }
        server {
          requestId
        }
      }
    }
  }

  fragment WeekDaysFilter_data on ItinerariesMetadata {
    inboundDays
    outboundDays
  }

  fragment useSortingModes_data on ItinerariesMetadata {
    topResults {
      best {
        __typename
        duration
        price {
          amount
        }
        id
      }
      cheapest {
        __typename
        duration
        price {
          amount
        }
        id
      }
      fastest {
        __typename
        duration
        price {
          amount
        }
        id
      }
      sourceTakeoffAsc {
        __typename
        duration
        price {
          amount
        }
        id
      }
      destinationLandingAsc {
        __typename
        duration
        price {
          amount
        }
        id
      }
    }
  }
"
