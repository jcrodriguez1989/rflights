search_one_way_itineraries_query <- "
  query SearchOneWayItinerariesQuery(
    $search: SearchOnewayInput
    $filter: ItinerariesFilterInput
    $options: ItinerariesOptionsInput
  ) {
    onewayItineraries(search: $search, filter: $filter, options: $options) {
      __typename
      ... on AppError {
        error: message
      }
      ... on Itineraries {
        server {
          requestId
          environment
          packageVersion
          serverToken
        }
        metadata {
          eligibilityInformation {
            baggageEligibilityInformation {
              topFiveResultsBaggageEligibleForPrompt
              numberOfBags
            }
            guaranteeAndRedirectsEligibilityInformation {
              redirect {
                anywhere
                top10
                isKiwiAvailable
              }
              guarantee {
                anywhere
                top10
              }
              combination {
                anywhere
                top10
              }
            }
            topThreeResortingOccurred
            carriersDeeplinkEligibility
            responseContainsKayakItinerary
          }
          carriers {
            code
            id
          }
          ...AirlinesFilter_data
          ...CountriesFilter_data
          ...WeekDaysFilter_data
          ...TravelTip_data
          ...Sorting_data
          ...useSortingModes_data
          ...PriceAlert_data
          itinerariesCount
          hasMorePending
          missingProviders {
            code
          }
          searchFingerprint
          statusPerProvider {
            provider {
              id
            }
            errorHappened
            errorMessage
          }
          hasTier1MarketItineraries
          isSortOrderSameAsDefault
          sharedItinerary {
            __typename
            ...TripInfo
            ... on ItineraryOneWay {
              ... on Itinerary {
                __isItinerary: __typename
                __typename
                id
                shareId
                price {
                  amount
                  priceBeforeDiscount
                }
                priceEur {
                  amount
                }
                provider {
                  name
                  code
                  hasHighProbabilityOfPriceChange
                  contentProvider {
                    code
                  }
                  id
                }
                bagsInfo {
                  includedCheckedBags
                  includedHandBags
                  hasNoBaggageSupported
                  hasNoCheckedBaggage
                  checkedBagTiers {
                    tierPrice {
                      amount
                    }
                    bags {
                      weight {
                        value
                      }
                    }
                  }
                  handBagTiers {
                    tierPrice {
                      amount
                    }
                    bags {
                      weight {
                        value
                      }
                    }
                  }
                  includedPersonalItem
                  personalItemTiers {
                    tierPrice {
                      amount
                    }
                    bags {
                      weight {
                        value
                      }
                      height {
                        value
                      }
                      width {
                        value
                      }
                      length {
                        value
                      }
                    }
                  }
                }
                bookingOptions {
                  edges {
                    node {
                      token
                      bookingUrl
                      trackingPixel
                      itineraryProvider {
                        code
                        name
                        subprovider
                        hasHighProbabilityOfPriceChange
                        contentProvider {
                          code
                        }
                        providerCategory
                        id
                      }
                      price {
                        amount
                      }
                      priceEur {
                        amount
                      }
                    }
                  }
                }
                travelHack {
                  isTrueHiddenCity
                  isVirtualInterlining
                  isThrowawayTicket
                }
                priceLocks {
                  priceLocksCurr {
                    default
                    price {
                      amount
                      roundedFormattedValue
                    }
                  }
                  priceLocksEur {
                    default
                    price {
                      amount
                      roundedFormattedValue
                    }
                  }
                }
              }
              legacyId
              sector {
                id
                sectorSegments {
                  guarantee
                  segment {
                    id
                    source {
                      localTime
                      utcTime
                      station {
                        id
                        legacyId
                        name
                        code
                        type
                        gps {
                          lat
                          lng
                        }
                        city {
                          legacyId
                          name
                          id
                        }
                        country {
                          code
                          id
                        }
                      }
                    }
                    destination {
                      localTime
                      utcTime
                      station {
                        id
                        legacyId
                        name
                        code
                        type
                        gps {
                          lat
                          lng
                        }
                        city {
                          legacyId
                          name
                          id
                        }
                        country {
                          code
                          id
                        }
                      }
                    }
                    duration
                    type
                    code
                    carrier {
                      id
                      name
                      code
                    }
                    operatingCarrier {
                      id
                      name
                      code
                    }
                    cabinClass
                    hiddenDestination {
                      code
                      name
                      city {
                        name
                        id
                      }
                      country {
                        name
                        id
                      }
                      id
                    }
                    throwawayDestination {
                      id
                    }
                  }
                  layover {
                    duration
                    isBaggageRecheck
                    isWalkingDistance
                    transferDuration
                    id
                  }
                }
                duration
              }
              lastAvailable {
                seatsLeft
              }
              isRyanair
              benefitsData {
                automaticCheckinAvailable
                instantChatSupportAvailable
                disruptionProtectionAvailable
                guaranteeAvailable
                guaranteeFee {
                  roundedAmount
                }
                searchReferencePrice {
                  roundedFormattedValue
                }
              }
            }
            id
          }
          kayakEligibilityTest {
            containsKayakWithNewRules
            containsKayakWithCurrentRules
            containsKayakAirlinesWithNewRules
          }
          extendedTrackingMetadata {
            fullResponse {
              allItineraries {
                numberOfKiwiOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKayakOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfDeeplinkOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKiwiAndKayakBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKiwiAndDeeplinkBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
              }
              filteredItineraries {
                numberOfKiwiOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKayakOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfDeeplinkOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKiwiAndKayakBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKiwiAndDeeplinkBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
              }
              airlineBreakdown {
                carriers {
                  code
                  id
                }
                allItineraries {
                  numberOfKiwiOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKayakOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfDeeplinkOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKiwiAndKayakBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKiwiAndDeeplinkBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                }
                filteredItineraries {
                  numberOfKiwiOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKayakOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfDeeplinkOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKiwiAndKayakBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKiwiAndDeeplinkBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                }
              }
            }
            topTenInResponse {
              allItineraries {
                numberOfKiwiOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKayakOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfDeeplinkOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKiwiAndKayakBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKiwiAndDeeplinkBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
              }
              filteredItineraries {
                numberOfKiwiOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKayakOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfDeeplinkOnlyBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKiwiAndKayakBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
                numberOfKiwiAndDeeplinkBookingOptionItineraries {
                  beforeMerging
                  afterMerging
                }
              }
              airlineBreakdown {
                carriers {
                  name
                  code
                  id
                }
                allItineraries {
                  numberOfKiwiOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKayakOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfDeeplinkOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKiwiAndKayakBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKiwiAndDeeplinkBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                }
                filteredItineraries {
                  numberOfKiwiOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKayakOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfDeeplinkOnlyBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKiwiAndKayakBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                  numberOfKiwiAndDeeplinkBookingOptionItineraries {
                    beforeMerging
                    afterMerging
                  }
                }
              }
            }
          }
        }
        itineraries {
          __typename
          ...TripInfo
          ... on ItineraryOneWay {
            ... on Itinerary {
              __isItinerary: __typename
              __typename
              id
              shareId
              price {
                amount
                priceBeforeDiscount
              }
              priceEur {
                amount
              }
              provider {
                name
                code
                hasHighProbabilityOfPriceChange
                contentProvider {
                  code
                }
                id
              }
              bagsInfo {
                includedCheckedBags
                includedHandBags
                hasNoBaggageSupported
                hasNoCheckedBaggage
                checkedBagTiers {
                  tierPrice {
                    amount
                  }
                  bags {
                    weight {
                      value
                    }
                  }
                }
                handBagTiers {
                  tierPrice {
                    amount
                  }
                  bags {
                    weight {
                      value
                    }
                  }
                }
                includedPersonalItem
                personalItemTiers {
                  tierPrice {
                    amount
                  }
                  bags {
                    weight {
                      value
                    }
                    height {
                      value
                    }
                    width {
                      value
                    }
                    length {
                      value
                    }
                  }
                }
              }
              bookingOptions {
                edges {
                  node {
                    token
                    bookingUrl
                    trackingPixel
                    itineraryProvider {
                      code
                      name
                      subprovider
                      hasHighProbabilityOfPriceChange
                      contentProvider {
                        code
                      }
                      providerCategory
                      id
                    }
                    price {
                      amount
                    }
                    priceEur {
                      amount
                    }
                  }
                }
              }
              travelHack {
                isTrueHiddenCity
                isVirtualInterlining
                isThrowawayTicket
              }
              priceLocks {
                priceLocksCurr {
                  default
                  price {
                    amount
                    roundedFormattedValue
                  }
                }
                priceLocksEur {
                  default
                  price {
                    amount
                    roundedFormattedValue
                  }
                }
              }
            }
            legacyId
            sector {
              id
              sectorSegments {
                guarantee
                segment {
                  id
                  source {
                    localTime
                    utcTime
                    station {
                      id
                      legacyId
                      name
                      code
                      type
                      gps {
                        lat
                        lng
                      }
                      city {
                        legacyId
                        name
                        id
                      }
                      country {
                        code
                        id
                      }
                    }
                  }
                  destination {
                    localTime
                    utcTime
                    station {
                      id
                      legacyId
                      name
                      code
                      type
                      gps {
                        lat
                        lng
                      }
                      city {
                        legacyId
                        name
                        id
                      }
                      country {
                        code
                        id
                      }
                    }
                  }
                  duration
                  type
                  code
                  carrier {
                    id
                    name
                    code
                  }
                  operatingCarrier {
                    id
                    name
                    code
                  }
                  cabinClass
                  hiddenDestination {
                    code
                    name
                    city {
                      name
                      id
                    }
                    country {
                      name
                      id
                    }
                    id
                  }
                  throwawayDestination {
                    id
                  }
                }
                layover {
                  duration
                  isBaggageRecheck
                  isWalkingDistance
                  transferDuration
                  id
                }
              }
              duration
            }
            lastAvailable {
              seatsLeft
            }
            isRyanair
            benefitsData {
              automaticCheckinAvailable
              instantChatSupportAvailable
              disruptionProtectionAvailable
              guaranteeAvailable
              guaranteeFee {
                roundedAmount
              }
              searchReferencePrice {
                roundedFormattedValue
              }
            }
          }
          id
        }
      }
    }
  }

  fragment AirlinesFilter_data on ItinerariesMetadata {
    carriers {
      id
      code
      name
    }
  }

  fragment CountriesFilter_data on ItinerariesMetadata {
    stopoverCountries {
      code
      name
      id
    }
  }

  fragment PrebookingStation on Station {
    code
    type
    city {
      name
      id
    }
  }

  fragment PriceAlert_data on ItinerariesMetadata {
    priceAlertExists
    existingPriceAlert {
      id
    }
    searchFingerprint
    hasMorePending
    priceAlertsTopResults {
      best {
        price {
          amount
        }
      }
      cheapest {
        price {
          amount
        }
      }
      fastest {
        price {
          amount
        }
      }
      sourceTakeoffAsc {
        price {
          amount
        }
      }
      destinationLandingAsc {
        price {
          amount
        }
      }
    }
  }

  fragment Sorting_data on ItinerariesMetadata {
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

  fragment TravelTip_data on ItinerariesMetadata {
    travelTips {
      __typename
      ... on TravelTipRadiusMoney {
        radius
        params {
          name
          value
        }
        savingMoney: saving {
          amount
          currency {
            id
            code
            name
          }
          formattedValue
        }
        location {
          __typename
          id
          legacyId
          name
          slug
        }
      }
      ... on TravelTipRadiusTime {
        radius
        params {
          name
          value
        }
        saving
        location {
          __typename
          id
          legacyId
          name
          slug
        }
      }
      ... on TravelTipRadiusSome {
        radius
        params {
          name
          value
        }
        location {
          __typename
          id
          legacyId
          name
          slug
        }
      }
      ... on TravelTipDateMoney {
        dates {
          start
          end
        }
        params {
          name
          value
        }
        savingMoney: saving {
          amount
          currency {
            id
            code
            name
          }
          formattedValue
        }
      }
      ... on TravelTipDateTime {
        dates {
          start
          end
        }
        params {
          name
          value
        }
        saving
      }
      ... on TravelTipDateSome {
        dates {
          start
          end
        }
        params {
          name
          value
        }
      }
      ... on TravelTipExtend {
        destination {
          __typename
          id
          name
          slug
        }
        locations {
          __typename
          id
          name
          slug
        }
        price {
          amount
          currency {
            id
            code
            name
          }
          formattedValue
        }
      }
    }
  }

  fragment TripInfo on Itinerary {
    __isItinerary: __typename
    ... on ItineraryOneWay {
      sector {
        sectorSegments {
          segment {
            source {
              station {
                ...PrebookingStation
                id
              }
              localTime
            }
            destination {
              station {
                ...PrebookingStation
                id
              }
            }
            id
          }
        }
        id
      }
    }
    ... on ItineraryReturn {
      outbound {
        sectorSegments {
          segment {
            source {
              station {
                ...PrebookingStation
                id
              }
              localTime
            }
            destination {
              station {
                ...PrebookingStation
                id
              }
            }
            id
          }
        }
        id
      }
      inbound {
        sectorSegments {
          segment {
            destination {
              station {
                ...PrebookingStation
                id
              }
              localTime
            }
            id
          }
        }
        id
      }
    }
    ... on ItineraryMulticity {
      sectors {
        sectorSegments {
          segment {
            source {
              station {
                ...PrebookingStation
                id
              }
              localTime
            }
            destination {
              station {
                ...PrebookingStation
                id
              }
              localTime
            }
            id
          }
        }
        id
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
