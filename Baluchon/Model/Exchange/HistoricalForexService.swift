//
//  HistoricalForexService.swift
//  Baluchon
//
//  Created by David Dubez on 08/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation
class HistoricalForexService {
    
    private var session = URLSession(configuration: .default)
    
    private static let ratedCurrency = "USD"
    private static let baseCurrency = "EUR"
    
    private var task: URLSessionDataTask?
    
    func getHistoricalRate(date: String, completionHandler: @escaping ((Forex?) -> Void)) {
        let session = URLSession(configuration: .default)
        
        task?.cancel()
        task = session.dataTask(with: URL(string: "http://data.fixer.io/api/" + date + "?access_key=" + ServicesKey.apiKeyForex
            + "&symbols=" + HistoricalForexService.ratedCurrency + "&base=" + HistoricalForexService.baseCurrency)!) { (data, response, error) in
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
    
  
}
// TODO: Mettre commentaires
