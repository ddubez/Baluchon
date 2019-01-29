//
//  ForexServiceTestCase.swift
//  BaluchonTests
//
//  Created by David Dubez on 27/01/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import XCTest
@testable import Baluchon

class ForexServiceTestCase: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testGetForexShouldPostFailedCallbackIfError() {
        // Given
        let forexService = ForexService(
            session: URLSessionFake(data: nil,
                                    response: nil,
                                    error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        forexService.getForex { (success, forex, error) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(forex)
            XCTAssertEqual(error, "error in data")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetForexShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let forexService = ForexService(
            session: URLSessionFake(data: FakeResponseData.forexCorrectData,
                                    response: FakeResponseData.responseKO,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        forexService.getForex { (success, forex, error) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(forex)
            XCTAssertEqual(error, "error in statusCode")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetForexShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let forexService = ForexService(
            session: URLSessionFake(data: FakeResponseData.forexIncorrectData,
                                    response: FakeResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        forexService.getForex { (success, forex, error) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(forex)
            XCTAssertEqual(error, "error in JSONDecoder")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetForexShouldPostFailedCallbackIfNoSuccesInForex() {
        // Given
        let forexService = ForexService(
            session: URLSessionFake(data: FakeResponseData.forexCorrectDataWithNoSuccess,
                                    response: FakeResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        forexService.getForex { (success, forex, error) in
            // Then
            XCTAssertFalse(success)
            XCTAssertEqual(error,
                           "You have not supplied a valid API Access Key. [Technical Support: support@apilayer.com]")
            XCTAssertNil(forex)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetForexShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let forexService = ForexService(
            session: URLSessionFake(data: FakeResponseData.forexCorrectData,
                                    response: FakeResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        forexService.getForex { (success, forex, error) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(forex)
            XCTAssertEqual(error, "")

            let success = true
            let timestamp = 1548576847
            let base = "EUR"
            let date = "2019-01-27"
            let rates = Rates(USD: 1.140049)

            XCTAssertEqual(success, forex!.success)
            XCTAssertEqual(timestamp, forex!.timestamp)
            XCTAssertEqual(base, forex!.base)
            XCTAssertEqual(date, forex!.date)
            XCTAssertEqual(rates.USD, forex!.rates?.USD)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
// TODO: completer pour 100% de coverage
