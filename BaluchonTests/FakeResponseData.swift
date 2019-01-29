//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by David Dubez on 27/01/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

class FakeResponseData {

    // MARK: - Data
    static var forexCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Forex", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static var forexCorrectDataWithNoSuccess: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "WrongForex", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static let forexIncorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "http://data.fixer.io")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://data.fixer.io")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class ForexError: Error {}
    static let error = ForexError()
}
