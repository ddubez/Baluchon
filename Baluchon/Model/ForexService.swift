//
//  ForexService.swift
//  Baluchon
//
//  Created by David Dubez on 25/01/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

class ForexService {

    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session = session
    }

    static var shared = ForexService()
    private init() {}

    private static let ratedCurrency = "USD"
    private static let baseCurrency = "EUR"
    private static let urlString = "http://data.fixer.io/api/latest?access_key=" + ServicesKey.apiKeyForex
                                    + "&symbols=" + ratedCurrency + "&base=" + baseCurrency

    private static let latestForexUrl = URL(string: urlString)!

 private var task: URLSessionDataTask?

    func getForex(callBack: @escaping (Bool, Forex?, String) -> Void) {
        let request = createForexRequest()

        task?.cancel()

        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil, "error in data")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil, "error in statusCode")
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Forex.self, from: data) else {
                        callBack(false, nil, "error in JSONDecoder")
                        return
                }
                guard responseJSON.success == true else {
                    callBack(false, nil, responseJSON.error!.info)
                    return
                }
                let forex = responseJSON
                callBack(true, forex, "")
            }
        }
        task?.resume()
    }

    private func createForexRequest() -> URLRequest {
        var request = URLRequest(url: ForexService.latestForexUrl)
        request.httpMethod = "GET"

        return request
    }
}
// TODO: Mettre commentaires
