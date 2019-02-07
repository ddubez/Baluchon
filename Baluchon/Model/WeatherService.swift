//
//  WeatherService.swift
//  Baluchon
//
//  Created by David Dubez on 03/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

class WeatherService {

    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session = session
    }

    static var shared = WeatherService()
    private init() {}

    private static let urlString = "http://api.openweathermap.org/data/2.5/group"

    private var task: URLSessionDataTask?

    func getWeather(firstCityId: String, secondCityId: String, callBack: @escaping (Bool, WeatherData?, String) -> Void) {
        let request = createWeatherRequest(firstCityId: firstCityId, secondCityId: secondCityId)

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
                guard let responseJSON = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                    callBack(false, nil, "error in JSONDecoder")
                    return
                }

                let weatherData = responseJSON
                callBack(true, weatherData, "")
            }
        }
        task?.resume()
    }

    private func createWeatherRequest(firstCityId: String, secondCityId: String) -> URLRequest {
        let weatherUrlStringWithKey = WeatherService.urlString + "?id=" + firstCityId + "," + secondCityId + "&APPID=" + ServicesKey.apiKeyWeather + "&units=metric" + "&lang=fr"
        
        let weatherUrl = URL(string: weatherUrlStringWithKey)!

        var request = URLRequest(url: weatherUrl)
        request.httpMethod = "POST"

        return request
    }
}

// TODO: Mettre commentaires
// TODO: Test a faire
