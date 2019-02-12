//
//  FakeTranslationServiceResponseData.swift
//  BaluchonTests
//
//  Created by David Dubez on 12/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

class FakeTranslationResponseData {
    
    // MARK: - Data
    static var translationCorrectData: Data? {
        let bundle = Bundle(for: FakeTranslationResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var translationCorrectDataWithNoSuccess: Data? {
        let bundle = Bundle(for: FakeTranslationResponseData.self)
        let url = bundle.url(forResource: "WrongTranslation", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static let translationIncorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "http://goodResponse")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://badResponse")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
    class TranslationError: Error {}
    static let error = TranslationError()
}
