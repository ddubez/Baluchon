//
//  WeatherDataDisplay.swift
//  Baluchon
//
//  Created by David Dubez on 07/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import UIKit

class WeatherDataDisplay: UIStackView {
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var weatherIconImage: UIImageView!
    @IBOutlet private var weatherDescriptionLabel: UILabel!
    @IBOutlet private var mainTempLabel: UILabel!
    @IBOutlet private var mainPressureLabel: UILabel!
    @IBOutlet private var mainHumidityLabel: UILabel!
    @IBOutlet private var mainTempMinLabel: UILabel!
    @IBOutlet private var mainTempMaxLabel: UILabel!
    @IBOutlet private var sysSunriseLabel: UILabel!
    @IBOutlet private var sysSunsetLabel: UILabel!
    @IBOutlet private var coordonnateLabel: UILabel!
    
    var cityName = "" {
        didSet {
            cityLabel.text = cityName
        }
    }
    var weatherImage = UIImage(named: "weatherIcon")  {
        didSet {
            weatherIconImage.image = weatherImage
        }
    }
    var weatherDescription = "" {
        didSet {
            weatherDescriptionLabel.text = weatherDescription
        }
    }
    var mainTemp = "" {
        didSet {
            mainTempLabel.text = mainTemp
        }
    }
    var mainPressure = "" {
        didSet {
            mainPressureLabel.text = mainPressure
        }
    }
    var mainHumidity = "" {
        didSet {
            mainHumidityLabel.text = mainHumidity
        }
    }
    var mainTempMin = "" {
        didSet {
            mainTempMinLabel.text = mainTempMin
        }
    }
    var mainTempMax = "" {
        didSet {
            mainTempMaxLabel.text = mainTempMax
        }
    }
    var sysSunrise = "" {
        didSet {
            sysSunriseLabel.text = sysSunrise
        }
    }
    var sysSunset = "" {
        didSet {
            sysSunsetLabel.text = sysSunset
        }
    }
    var coordonnate = "" {
        didSet {
            coordonnateLabel.text = coordonnate
        }
    }
}
