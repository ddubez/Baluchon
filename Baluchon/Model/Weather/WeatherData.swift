//
//  WeatherData.swift
//  Baluchon
//
//  Created by David Dubez on 03/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    // creation of structure like JSON model response
    var cod: Int?
    var message: String?
    var cnt: Int?
    var list: [List]?

    struct List: Decodable {
        var coord: Coord
        var sys: Sys
        var weather: [Weather]
        var base: String?
        var main: Main
        var visibility: Double?
        var wind: Wind?
        var clouds: Clouds?
        var rain: Rain?
        var snow: Snow?
        var dataCalculationTime: Int
        var cityId: Int
        var name: String
        var cod: Int?
    }
    struct Coord: Decodable {
        var lon: Double
        var lat: Double
    }
    struct Sys: Decodable {
        var type: Int
        var sysId: Int
        var message: Double
        var country: String
        var sunrise: Double
        var sunset: Double
    }
    struct Weather: Decodable {
        var weatherId: Int
        var main: String
        var description: String
        var icon: String
        var iconImage: Data?
    }
    struct Main: Decodable {
        var temp: Double
        var pressure: Double
        var humidity: Double
        var tempMin: Double
        var tempMax: Double
        var seaLevel: Double?
        var grndLevel: Double?
    }
    struct Wind: Decodable {
        var speed: Double
        var deg: Double
    }
    struct Clouds: Decodable {
        var all: Double
    }
    struct Rain: Decodable {
        var oneH: Double
        var treeH: Double
    }
    struct Snow: Decodable {
        var oneH: Double
        var treeH: Double
    }
}

// MARK: - CodingKey
extension WeatherData.List {
    enum CodingKeys: String, CodingKey {
        case coord, sys, weather, base, main, visibility, wind, clouds, rain, snow, name, cod
        case dataCalculationTime = "dt"
        case cityId = "id"
    }
}
extension WeatherData.Sys {
    enum CodingKeys: String, CodingKey {
        case type, message, country, sunrise, sunset
        case sysId = "id"
    }
}
extension WeatherData.Weather {
    enum CodingKeys: String, CodingKey {
        case main, description, icon, iconImage
        case weatherId = "id"
    }
}
extension WeatherData.Main {
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}
extension WeatherData.Rain {
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
        case treeH = "3h"
    }
}
extension WeatherData.Snow {
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
        case treeH = "3h"
    }
}
