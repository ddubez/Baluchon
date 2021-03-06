//
//  HistoricalForexService.swift
//  Baluchon
//
//  Created by David Dubez on 08/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation
class HistoricalForexService {
    // network request for retrieve historical rates data in Forex Class

    // MARK: - PROPERTIES
    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session = session
    }

    private static let baseUrlString = "http://data.fixer.io/api/"
    private static let baseHistoricalForexUrl = URL(string: baseUrlString)!

    private var task: URLSessionDataTask?

    // MARK: - FUCNTIONS
    func getHistoricalRate(date: String, completionHandler: @escaping ((Forex?) -> Void)) {
        let request = createForexRequest(date: date, ratedCurrency: "USD", baseCurrency: "EUR")

        task?.cancel()

        task = session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        completionHandler(nil)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completionHandler(nil)
                        return
                    }
                    guard let responseJSON = try? JSONDecoder().decode(Forex.self, from: data) else {
                        completionHandler(nil)
                        return
                    }
                    guard responseJSON.success == true else {
                        completionHandler(nil)
                        return
                    }
                    let forex = responseJSON
                    completionHandler(forex)
                }
        }
        task?.resume()
    }

    private func createForexRequest(date: String, ratedCurrency: String, baseCurrency: String) -> URLRequest {

        let query: [String: String] = [
            "access_key": ServicesKey.apiKeyForex,
            "symbols": ratedCurrency,
            "base": baseCurrency
        ]

        var historicalForexUrl = HistoricalForexService.baseHistoricalForexUrl.withQueries(query)!
        historicalForexUrl.appendPathComponent(date)
        var request = URLRequest(url: historicalForexUrl)
        request.httpMethod = "GET"

        return request
    }
}
