//
//  Conversion.swift
//  Baluchon
//
//  Created by David Dubez on 29/01/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

class Conversion {
    // MARK: - PROPERTIES
    var amountConverted: Double = 0

    var way: Way = .normal

    enum Way {
        case normal
        case reserse
    }

    // MARK: - METHODS
    func convert(_ number: Double, rate: Double) {
        switch way {
        case .normal:
            amountConverted = number * rate
        case .reserse:
            amountConverted = number / rate
        }
    }
}
