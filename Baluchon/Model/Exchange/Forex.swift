//
//  Forex.swift
//  Baluchon
//
//  Created by David Dubez on 25/01/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

struct Forex: Decodable {
    var success: Bool
    var timestamp: Int?
    var base: String?
    var date: String?
    var rates: Rates?
    var error: Error?
    var historical: Bool?
}

struct Rates: Decodable {
    var USD: Double
}

struct Error: Decodable {
    var code: Int
    var type: String
    var info: String
}

struct TimeSerieValue: Decodable {
    var date: Date
    var value: Double
}

