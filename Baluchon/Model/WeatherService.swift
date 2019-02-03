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

    private static let apiKey = "b12208e23b060ac0f058c7572534a142"
    private static let urlString = "api.openweathermap.org/data/2.5/weather"

    private static let weatherUrl = URL(string: urlString)!

    private var task: URLSessionDataTask?

    func getWeather(firstCityId: String, secondCityId: String, callBack: @escaping (Bool, Weather?, String) -> Void) {
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
                guard let responseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callBack(false, nil, "error in JSONDecoder")
                    return
                }

                let weather = responseJSON
                callBack(true, weather, "")
            }
        }
        task?.resume()
    }

    private func createWeatherRequest(firstCityId: String, secondCityId: String) -> URLRequest {
        var request = URLRequest(url: WeatherService.weatherUrl)
        request.httpMethod = "POST"

        let body =  "q=" + firstCityId + "," + secondCityId +
            "&APPID=" + WeatherService.apiKey
        request.httpBody = body.data(using: .utf8)

        return request
    }
}

// TODO: Mettre commentaires
// TODO: Test a faire
