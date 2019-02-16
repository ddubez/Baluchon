//
//  TranslationServiceTestCase.swift
//  BaluchonTests
//
//  Created by David Dubez on 12/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import XCTest
@testable import Baluchon

class TranslationServiceTestCase: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testGetTranslationShouldPostFailedCallbackIfError() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: nil,
                                    response: nil,
                                    error: FakeTranslationResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: "Bonjour",
                                          source: "fr",
                                          target: "en") { (success, translation, error) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            XCTAssertEqual(error, "error in data")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: FakeTranslationResponseData.translationCorrectData,
                                    response: FakeTranslationResponseData.responseKO,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
       translationService.getTranslation(textToTranslate: "Bonjour",
                                         source: "fr",
                                         target: "en") { (success, translation, error) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            XCTAssertEqual(error, "error in statusCode")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: FakeTranslationResponseData.translationIncorrectData,
                                    response: FakeTranslationResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: "Bonjour",
                                          source: "fr",
                                          target: "en") { (success, translation, error) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            XCTAssertEqual(error, "error in JSONDecoder")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfNoSuccesInTranslation() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: FakeTranslationResponseData.translationCorrectDataWithNoSuccess,
                                    response: FakeTranslationResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
         translationService.getTranslation(textToTranslate: "Bonjour",
                                           source: "fr",
                                           target: "en") { (success, translation, error) in
            // Then
            XCTAssertFalse(success)
            XCTAssertEqual(error,
                           "API key not valid. Please pass a valid API key.")
            XCTAssertNil(translation)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translationService = TranslationService(
            session: URLSessionFake(data: FakeTranslationResponseData.translationCorrectData,
                                    response: FakeTranslationResponseData.responseOK,
                                    error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: "Bonjour",
                                          source: "fr",
                                          target: "en") { (success, translation, error) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(translation)
            XCTAssertEqual(error, "")

            let translatedText = "Hello"

            XCTAssertEqual(translatedText, translation!.data?.translations[0].translatedText)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationServiceShouldPostSuccessCallback() {
        // Given

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        TranslationService.shared.getTranslation(textToTranslate: "Bonjour",
                                                 source: "fr",
                                                 target: "en") { (success, translation, error) in
            // Then
            XCTAssertTrue(success)
            XCTAssertEqual(error, "")

            let translatedText = "Hello"
            XCTAssertEqual(translatedText, translation!.data?.translations[0].translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
