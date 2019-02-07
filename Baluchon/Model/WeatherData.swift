//
//  WeatherData.swift
//  Baluchon
//
//  Created by David Dubez on 03/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    var cod: String?
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
        var dt: Int
        var id: Int
        var name: String
        var cod: Int?
    }
    struct Coord: Decodable {
        var lon: Double
        var lat: Double
    }
    struct Sys: Decodable {
        var type: Int
        var id: Int
        var message: Double
        var country: String
        var sunrise: Int
        var sunset: Int
    }
    struct Weather: Decodable {
        var id: Int
        var main: String
        var description: String
        var icon: String
    }
    struct Main: Decodable {
        var temp: Double
        var pressure: Double?
        var humidity: Double?
        var tempMin: Double
        var tempMax: Double
        var seaLevel: Double?
        var grndLevel: Double?

        enum CodingKeys : String, CodingKey {
            case temp
            case pressure
            case humidity
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }
    struct Wind: Decodable {
        var speed: Double
        var deg: Double
    }
    struct Clouds: Decodable {
        var all: Double
    }
    struct Rain: Decodable{
        var oneH: Double
        var treeH: Double
    
        enum CodingKeys : String, CodingKey {
            case oneH = "1h"
            case treeH = "3h"
        }
    }
    struct Snow: Decodable{
        var oneH: Double
        var treeH: Double
        
        enum CodingKeys : String, CodingKey {
            case oneH = "1h"
            case treeH = "3h"
        }
    }
}

// TODO: Mettre commentaires
// TODO: Remettre swift Link ?????
/* swiftlint
else
echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
 */

