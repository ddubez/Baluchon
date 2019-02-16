//
//  WeatherServiceTestCase.swift
//  BaluchonTests
//
//  Created by David Dubez on 12/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import XCTest
@testable import Baluchon

class WeatherServiceTestCase: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    // MARK: - GETWEATHER TESTS

    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: nil,
                                    response: nil,
                                    error: FakeWeatherResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(firstCityId: "5128581",
                                  secondCityId: "3031582") { (success, weatherDataList, error) in

            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDataList)
            XCTAssertEqual(error, "error in data")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectData,
                                    response: FakeWeatherResponseData.responseKO,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(firstCityId: "5128581",
                                  secondCityId: "3031582") { (success, weatherDataList, error) in

            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDataList)
            XCTAssertEqual(error, "error in statusCode")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeWeatherResponseData.weatherIncorrectData,
                                    response: FakeWeatherResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(firstCityId: "5128581",
                                  secondCityId: "3031582") { (success, weatherDataList, error) in

            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDataList)
            XCTAssertEqual(error, "error in JSONDecoder")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfNoSuccesInWeather() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectDataWithNoSuccess,
                                    response: FakeWeatherResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(firstCityId: "5128581",
                                  secondCityId: "3031582") { (success, weatherDataList, error) in

            // Then
            XCTAssertFalse(success)
            XCTAssertEqual(error,
                           "Invalid API key. Please see http://openweathermap.org/faq#error401 for more info.")
            XCTAssertNil(weatherDataList)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectData,
                                    response: FakeWeatherResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(firstCityId: "5128581",
                                  secondCityId: "3031582") { (success, weatherDataList, error) in

            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherDataList)
            XCTAssertEqual(error, "")

            let firstCityName = "New York"
            let firstCityCountry = "US"
            let secondCityName = "Bordeaux"
            let secondCityCountry = "FR"

            XCTAssertEqual(firstCityName, weatherDataList![0].name)
            XCTAssertEqual(firstCityCountry, weatherDataList![0].sys.country)
            XCTAssertEqual(secondCityName, weatherDataList![1].name)
            XCTAssertEqual(secondCityCountry, weatherDataList![1].sys.country)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherServiceShouldPostSuccessCallback() {
        // Given

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        WeatherService.shared.getWeather(firstCityId: "5128581",
                                         secondCityId: "3031582") { (success, weatherDataList, error) in

            // Then
            XCTAssertTrue(success)
            XCTAssertEqual(error, "")

            let firstCityName = "New York"
            let firstCityCountry = "US"
            let secondCityName = "Bordeaux"
            let secondCityCountry = "FR"

            XCTAssertEqual(firstCityName, weatherDataList![0].name)
            XCTAssertEqual(firstCityCountry, weatherDataList![0].sys.country)
            XCTAssertEqual(secondCityName, weatherDataList![1].name)
            XCTAssertEqual(secondCityCountry, weatherDataList![1].sys.country)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
