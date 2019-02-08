//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by David Dubez on 20/01/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    let newYorkId = "5128581"
    let bordeauxId = "3031582"
    
    // MARK: - OUTLETS
    @IBOutlet weak var didTapRefreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var upWeatherDataDisplay: WeatherDataDisplay!
    
    @IBOutlet weak var downWeatherDataDisplay: WeatherDataDisplay!
    
    
    
    
    // MARK: - IBACTIONS
    @IBAction func didTapRefresh(_ sender: UIButton) {
        refreshWeather()
    }
    
    // MARK: - FUNCTIONS
    
    private func toggleRefreshButton(working: Bool) {
        didTapRefreshButton.isHidden = working
        activityIndicator.isHidden = !working
    }
    private func refreshWeather() {
        toggleRefreshButton(working: true)
        WeatherService.shared.getWeather(firstCityId: newYorkId, secondCityId: bordeauxId) {(success, weatherDataList, error) in
                self.toggleRefreshButton(working: false)
                if success == true, let weatherDataList = weatherDataList {
                    self.setValuesForDataDisplay(self.upWeatherDataDisplay, with: weatherDataList[0])
                    self.setValuesForDataDisplay(self.downWeatherDataDisplay, with: weatherDataList[1])
                } else {
                    self.displayAlert(with: error)
                }
        }
    }
    private func setValuesForDataDisplay(_ dataDisplay: WeatherDataDisplay, with weatherDataList: WeatherData.List) {
        dataDisplay.cityName = weatherDataList.name + " (" + weatherDataList.sys.country + ")"
        dataDisplay.mainTemp = String(weatherDataList.main.temp) + " °C"
        dataDisplay.mainPressure = String(weatherDataList.main.pressure) + " hpa"
        dataDisplay.mainHumidity = String(weatherDataList.main.humidity) + " %"
        dataDisplay.mainTempMin = String(weatherDataList.main.tempMin) + " °C"
        dataDisplay.mainTempMax = String(weatherDataList.main.tempMax) + " °C"
        let sunriseDate = Date(timeIntervalSince1970: weatherDataList.sys.sunrise)
        dataDisplay.sysSunrise = "\(DateFormatter.localizedString(from: sunriseDate, dateStyle: .none, timeStyle: .short))"
        let sunsetDate = Date(timeIntervalSince1970: weatherDataList.sys.sunset)
        dataDisplay.sysSunset = "\(DateFormatter.localizedString(from: sunsetDate, dateStyle: .none, timeStyle: .short))"
        dataDisplay.coordonnate = String(weatherDataList.coord.lon) + " lon, " + String(weatherDataList.coord.lat) + " lat"
        dataDisplay.weatherImage = UIImage(data: weatherDataList.weather[0].iconImage!)
        
        for weather in weatherDataList.weather {
            dataDisplay.weatherDescription += weather.description
            dataDisplay.weatherDescription += " "
        }
    }
}

// MARK: - Alert
extension WeatherViewController {
    func displayAlert(with message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// TODO: faire un format different pour quand le chargement est en cours ou qu'il y a une erreur
// TODO: mettre une bousolle qui tourne avec le vent
// TODO: Charger l'affichage à l'ouverture de page
// TODO: Changer les message d'alerte en francais
// TODO: Mettre une image par defaut si on a pas d'image et mettre les données météos quand meme
// TODO: Mettre commentaires
