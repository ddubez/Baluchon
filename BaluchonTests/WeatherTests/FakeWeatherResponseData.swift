//
//  FakeWeatherResponseData.swift
//  BaluchonTests
//
//  Created by David Dubez on 12/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

class FakeWeatherResponseData {
    
    // MARK: - Data
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeWeatherResponseData.self)
        let url = bundle.url(forResource: "WeatherData", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var weatherCorrectDataWithNoSuccess: Data? {
        let bundle = Bundle(for: FakeWeatherResponseData.self)
        let url = bundle.url(forResource: "WrongWeatherData", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static let weatherIncorrectData = "erreur".data(using: .utf8)!
    static let imageData = "image".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "http://goodResponse")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://badResponse")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
    class WeatherError: Error {}
    static let error = WeatherError()
}
