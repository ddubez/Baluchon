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

    private static let WeatherBaseUrlString = "http://api.openweathermap.org/data/2.5/group"
    private static let WeatherBaseUrl = URL(string: WeatherBaseUrlString)!
    
    private static let IconImagesBaseUrlString = "http://openweathermap.org/img/w/"
    private static let IconImagesBaseUrl = URL(string: IconImagesBaseUrlString)!
    
    private var task: URLSessionDataTask?

    func getWeather(firstCityId: String, secondCityId: String, callBack: @escaping (Bool, [WeatherData.List]?, String) -> Void) {
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
                guard responseJSON.message == nil else {
                    callBack(false, nil, (responseJSON.message)!)
                    return
                }
                let weatherData = responseJSON
                
                guard var weatherDataList = weatherData.list else {
                    callBack(false, nil, "Désolé, il n'y a pas de données météo")
                    return
                }
                
                self.getIconImages(icon: weatherDataList[0].weather[0].icon) {(data) in
                    guard let data = data else {
                        callBack(false, nil, "Désolé, il n'y a pas d'image pour la ville 1")
                        return
                    }
                    weatherDataList[0].weather[0].iconImage = data
                    
                    self.getIconImages(icon: weatherDataList[1].weather[0].icon) {(data) in
                        guard let data = data else {
                            callBack(false, nil, "Désolé, il n'y a pas d'image pour la ville 2")
                            return
                        }
                        weatherDataList[1].weather[0].iconImage = data
                        
                        callBack(true, weatherDataList, "")
                }
                }
            }
        }
        task?.resume()
    }
    
    private func getIconImages(icon: String, completionHandler: @escaping ((Data?) -> Void)) {
        let session = URLSession(configuration: .default)
        var iconImagesUrl = WeatherService.IconImagesBaseUrl
        iconImagesUrl.appendPathComponent(icon + ".png")
        
        task?.cancel()
        task = session.dataTask(with: iconImagesUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(nil)
                    return
                }
                completionHandler(data)
            }
        }
        task?.resume()
    }
    private func createWeatherRequest(firstCityId: String, secondCityId: String) -> URLRequest {
        
        let query: [String: String] = [
            "id": (firstCityId + "," + secondCityId),
            "APPID": ServicesKey.apiKeyWeather,
            "units": "metric",
            "lang": "fr"
        ]
   
        let weatherUrl = WeatherService.WeatherBaseUrl.withQueries(query)!
        var request = URLRequest(url: weatherUrl)
        request.httpMethod = "POST"

        return request
    }
    
}

// TODO: Mettre commentaires
// TODO: Test a faire
