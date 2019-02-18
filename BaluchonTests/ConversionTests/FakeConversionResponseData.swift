//
//  FakeConversionResponseData.swift
//  BaluchonTests
//
//  Created by David Dubez on 27/01/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

class FakeConversionResponseData {

    // MARK: - Data
    static var forexCorrectData: Data? {
        let bundle = Bundle(for: FakeConversionResponseData.self)
        let url = bundle.url(forResource: "Forex", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static var forexCorrectDataWithNoSuccess: Data? {
        let bundle = Bundle(for: FakeConversionResponseData.self)
        let url = bundle.url(forResource: "WrongForex", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static var historicalForexCorrectData: Data? {
        let bundle = Bundle(for: FakeConversionResponseData.self)
        let url = bundle.url(forResource: "HistoricalForex", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static let forexIncorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "http://goodResponse")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://badResponse")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class ForexError: Error {}
    static let error = ForexError()
}
