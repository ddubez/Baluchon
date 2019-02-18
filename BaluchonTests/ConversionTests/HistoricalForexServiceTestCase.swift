//
//  HistoricalForexServiceTestCase.swift
//  BaluchonTests
//
//  Created by David Dubez on 12/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import XCTest
@testable import Baluchon

class HistoricalForexServiceTestCase: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testGetHistoricalForexShouldPostFailedCompletionHandlerIfError() {
        // Given
        let historicalforexService = HistoricalForexService(
            session: URLSessionFake(data: FakeConversionResponseData.historicalForexCorrectData,
                                    response: FakeConversionResponseData.responseOK,
                                    error: FakeConversionResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        historicalforexService.getHistoricalRate(date: "2019-01-01", completionHandler: { (forex) in

            // Then
            XCTAssertNil(forex)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetHistoricalForexShouldPostFailedCompletionHandlerIfIncorrectResponse() {
        // Given
        let historicalforexService = HistoricalForexService(
            session: URLSessionFake(data: FakeConversionResponseData.historicalForexCorrectData,
                                    response: FakeConversionResponseData.responseKO,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        historicalforexService.getHistoricalRate(date: "2019-01-01", completionHandler: { (forex) in

            // Then
            XCTAssertNil(forex)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetHistoricalForexShouldPostFailedCompletionHandlerIfIncorrectData() {
        // Given
        let historicalforexService = HistoricalForexService(
            session: URLSessionFake(data: FakeConversionResponseData.forexIncorrectData,
                                    response: FakeConversionResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        historicalforexService.getHistoricalRate(date: "2019-01-01", completionHandler: { (forex) in

            // Then
            XCTAssertNil(forex)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testHistoricalGetForexShouldPostFailedCompletionHandlerIfNoSuccesInForex() {
        // Given
        let historicalforexService = HistoricalForexService(
            session: URLSessionFake(data: FakeConversionResponseData.forexCorrectDataWithNoSuccess,
                                    response: FakeConversionResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        historicalforexService.getHistoricalRate(date: "2019-01-01", completionHandler: { (forex) in

            // Then
            XCTAssertNil(forex)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetHistoricalForexShouldPostSuccessCompletionHandlerIfNoErrorAndCorrectData() {
        // Given
        let historicalforexService = HistoricalForexService(
            session: URLSessionFake(data: FakeConversionResponseData.historicalForexCorrectData,
                                    response: FakeConversionResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        historicalforexService.getHistoricalRate(date: "2019-01-01", completionHandler: { (forex) in

            // Then
            XCTAssertNotNil(forex)

            let success = true
            let timestamp = 1546387199
            let base = "EUR"
            let date = "2019-01-01"
            let rates = Rates(USD: 1.146125)

            XCTAssertEqual(success, forex!.success)
            XCTAssertEqual(timestamp, forex!.timestamp)
            XCTAssertEqual(base, forex!.base)
            XCTAssertEqual(date, forex!.date)
            XCTAssertEqual(rates.USD, forex!.rates?.USD)

            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testHistoricalGetForexServiceShouldPostSuccessCompletionHandler() {
        // Given

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        HistoricalForexService(session: URLSession(configuration: .default)).getHistoricalRate(
            date: "2019-01-01", completionHandler: { (forex) in

            // Then

            let success = true
            let base = "EUR"
            let date = "2019-01-01"

            XCTAssertNotNil(forex)
            XCTAssertEqual(success, forex!.success)
            XCTAssertEqual(base, forex!.base)
            XCTAssertEqual(date, forex!.date)

            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
}
