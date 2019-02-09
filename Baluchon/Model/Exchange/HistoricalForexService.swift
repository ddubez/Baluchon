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
    
    init(session: URLSession) {
        self.session = session
    }
    
    static var shared = HistoricalForexService()
    private init() {}
    
    private static let ratedCurrency = "USD"
    private static let baseCurrency = "EUR"
    
    private var task: URLSessionDataTask?
    
    func getTimeSerie(callBack: @escaping (Bool, [String: Double]?, String) -> Void) {
        
        let dates = setHistoricalDates()
        var timeSeries = [String: Double]()
        
            
        // getting rate for date 1
        self.getHistoricalRate(date: dates[0]) { (forex) in
            guard let forex = forex else {
                callBack(false, nil, "Désolé, il n'y a pas de données historique")
                return
            }
            guard let forexrates = forex.rates else {
                callBack(false, nil, "Désolé, il n'y a pas de données historique")
                return }
            timeSeries[dates[0]] = forexrates.USD
            
            // getting rate for date 2
            self.getHistoricalRate(date: dates[1]) { (forex) in
                guard let forex = forex else {
                    callBack(false, nil, "Désolé, il n'y a pas de données historique")
                    return
                }
                guard let forexrates = forex.rates else {
                    callBack(false, nil, "Désolé, il n'y a pas de données historique")
                    return }
                timeSeries[dates[1]] = forexrates.USD
                
                // getting rate for date 3
                self.getHistoricalRate(date: dates[2]) { (forex) in
                    guard let forex = forex else {
                        callBack(false, nil, "Désolé, il n'y a pas de données historique")
                        return
                    }
                    guard let forexrates = forex.rates else {
                        callBack(false, nil, "Désolé, il n'y a pas de données historique")
                        return }
                    timeSeries[dates[2]] = forexrates.USD
                    
                    // getting rate for date 4
                    self.getHistoricalRate(date: dates[3]) { (forex) in
                        guard let forex = forex else {
                            callBack(false, nil, "Désolé, il n'y a pas de données historique")
                            return
                        }
                        guard let forexrates = forex.rates else {
                            callBack(false, nil, "Désolé, il n'y a pas de données historique")
                            return }
                        timeSeries[dates[3]] = forexrates.USD
                        
                        // getting rate for date 5
                        self.getHistoricalRate(date: dates[4]) { (forex) in
                            guard let forex = forex else {
                                callBack(false, nil, "Désolé, il n'y a pas de données historique")
                                return
                            }
                            guard let forexrates = forex.rates else {
                                callBack(false, nil, "Désolé, il n'y a pas de données historique")
                                return }
                            timeSeries[dates[4]] = forexrates.USD
                            
                            // getting rate for date 6
                            self.getHistoricalRate(date: dates[5]) { (forex) in
                                guard let forex = forex else {
                                    callBack(false, nil, "Désolé, il n'y a pas de données historique")
                                    return
                                }
                                guard let forexrates = forex.rates else {
                                    callBack(false, nil, "Désolé, il n'y a pas de données historique")
                                    return }
                                timeSeries[dates[5]] = forexrates.USD
                                
                                // getting rate for date 7
                                self.getHistoricalRate(date: dates[6]) { (forex) in
                                    guard let forex = forex else {
                                        callBack(false, nil, "Désolé, il n'y a pas de données historique")
                                        return
                                    }
                                    guard let forexrates = forex.rates else {
                                        callBack(false, nil, "Désolé, il n'y a pas de données historique")
                                        return }
                                    timeSeries[dates[6]] = forexrates.USD
                                    
                                    // send the callBack
                                    callBack(true, timeSeries, "")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
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
    
    private func setHistoricalDates() -> [String] {
        var historicalDates = [String]()
        
        var date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        historicalDates.append(formatter.string(from: date))
        
        for _ in 1...14 {
            date = date.addingTimeInterval(-86400)
            historicalDates.insert(formatter.string(from: date), at: 0)
        }
        return historicalDates
    }
}
// TODO: Mettre commentaires
