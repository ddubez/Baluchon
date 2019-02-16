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
    var weatherImage = UIImage(named: "weatherIcon") {
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
    enum Style {
        case dataLoaded, noData
    }
    var style: Style = .noData {
        didSet {
            setStyle(style)
        }
    }

    private func setStyle(_ style: Style) {
        switch style {
        case .dataLoaded:
            cityLabel.backgroundColor = #colorLiteral(red: 0.7031596303, green: 0.8029034734, blue: 0.8099379539, alpha: 1)
            weatherDescriptionLabel.backgroundColor = #colorLiteral(red: 0.7224442959, green: 0.8457520604, blue: 0.9047884941, alpha: 1)
            cityLabel.textColor = #colorLiteral(red: 0.7704077363, green: 0.3681732416, blue: 0.2172614336, alpha: 1)
            weatherDescriptionLabel.textColor = #colorLiteral(red: 0.08462960273, green: 0.5212771297, blue: 0.5258666277, alpha: 1)

        case .noData:
            cityLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cityLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            weatherDescriptionLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            weatherDescriptionLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cityName = "??"
            weatherImage = UIImage(named: "weatherIcon")
            weatherDescription = "Pas de données"
            mainTemp = "??"
            mainPressure = "-"
            mainHumidity = "-"
            mainTempMin = "-"
            mainTempMax = "-"
            sysSunrise = "-"
            sysSunset = "-"
            coordonnate = "-"
        }
    }
}
