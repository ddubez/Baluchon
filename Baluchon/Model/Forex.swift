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
}

struct Rates: Decodable {
    var USD: Double
}

struct Error: Decodable {
    var code: Int
    var type: String
    var info: String
}
// TODO: Mettre commentaires
// TODO: voir si on declrare pas les tructure error a l'interreirude la struc Forex
// TODO: Recuperer les données sur plusieurs jours et afficher graph dans view

//"success": true,
//"timeseries": true,
//"start_date": "2012-05-01",
//"end_date": "2012-05-03",
//"base": "EUR",
//"rates": {
//    "2012-05-01":{
//        "USD": 1.322891,
//        "AUD": 1.278047,
//        "CAD": 1.302303
//    },
//    "2012-05-02": {
//        "USD": 1.315066,
//        "AUD": 1.274202,
//        "CAD": 1.299083
