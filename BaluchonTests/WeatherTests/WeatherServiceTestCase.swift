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
            weatherSession: URLSessionFake(data: nil,
                                    response: nil,
                                    error: FakeWeatherResponseData.error),
            imageSession: URLSessionFake(data: nil, response: nil, error: nil))

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
            weatherSession: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectData,
                                    response: FakeWeatherResponseData.responseKO,
                                    error: nil),
            imageSession: URLSessionFake(data: nil, response: nil, error: nil))

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
            weatherSession: URLSessionFake(data: FakeWeatherResponseData.weatherIncorrectData,
                                    response: FakeWeatherResponseData.responseOK,
                                    error: nil),
            imageSession: URLSessionFake(data: nil, response: nil, error: nil))

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
            weatherSession: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectDataWithNoSuccess,
                                    response: FakeWeatherResponseData.responseOK,
                                    error: nil),
            imageSession: URLSessionFake(data: nil, response: nil, error: nil))

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

    func testGetWeatherShouldPostFailedCallbackIfNoListInWeather() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectDataWithEmptyList,
                                    response: FakeWeatherResponseData.responseOK,
                                    error: nil),
            imageSession: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(firstCityId: "5128581",
                                  secondCityId: "3031582") { (success, weatherDataList, error) in

                                    // Then
                                    XCTAssertFalse(success)
                                    XCTAssertEqual(error, "Désolé, il n'y a pas de données météo")
                                    XCTAssertNil(weatherDataList)

                                    expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfErrorInImageforCityInWeather() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectData,
                                    response: FakeWeatherResponseData.responseOK,
                                    error: nil),
            imageSession: URLSessionFake(data: FakeWeatherResponseData.imageData,
                                         response: FakeWeatherResponseData.responseOK,
                                         error: FakeWeatherResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(firstCityId: "5128581",
                                  secondCityId: "3031582") { (success, weatherDataList, error) in

                                    // Then
                                    XCTAssertFalse(success)
                                    XCTAssertEqual(error, "Désolé, il n'y a pas d'image pour la ville")
                                    XCTAssertNil(weatherDataList)

                                    expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponseInImageforCityInWeather() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectData,
                                           response: FakeWeatherResponseData.responseOK,
                                           error: nil),
            imageSession: URLSessionFake(data: FakeWeatherResponseData.imageData,
                                         response: FakeWeatherResponseData.responseKO,
                                         error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(firstCityId: "5128581",
                                  secondCityId: "3031582") { (success, weatherDataList, error) in

                                // Then
                                XCTAssertFalse(success)
                                XCTAssertEqual(error, "Désolé, il n'y a pas d'image pour la ville")
                                XCTAssertNil(weatherDataList)

                                expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorCorrectDataAndImageforCityInWeather() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectData,
                                           response: FakeWeatherResponseData.responseOK,
                                           error: nil),
            imageSession: URLSessionFake(data: FakeWeatherResponseData.imageData,
                                         response: FakeWeatherResponseData.responseOK,
                                         error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(firstCityId: "5128581",
                                  secondCityId: "3031582") { (success, weatherDataList, error) in

                                // Then
                                XCTAssertTrue(success)
                                XCTAssertEqual(error, "")
                                XCTAssertNotNil(weatherDataList)

                                let firstCityName = "New York"
                                let firstCityCountry = "US"
                                let secondCityName = "Bordeaux"
                                let secondCityCountry = "FR"

                                XCTAssertEqual(firstCityName, weatherDataList![0].name)
                                XCTAssertEqual(firstCityCountry, weatherDataList![0].sys.country)
                                XCTAssertEqual(secondCityName, weatherDataList![1].name)
                                XCTAssertEqual(secondCityCountry, weatherDataList![1].sys.country)

                                let imageData = "image".data(using: .utf8)!
                                XCTAssertEqual(weatherDataList![0].weather[0].iconImage, imageData)
                                XCTAssertEqual(weatherDataList![1].weather[0].iconImage, imageData)

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
