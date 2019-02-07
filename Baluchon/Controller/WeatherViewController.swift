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
    @IBOutlet weak var firstCityTemperature: UILabel!
    @IBOutlet weak var secondCityTemperature: UILabel!
    
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
        WeatherService.shared.getWeather(firstCityId: newYorkId, secondCityId: bordeauxId) {(success, weatherData, error) in
                self.toggleRefreshButton(working: false)
                if success == true, let weatherData = weatherData {
                    guard let weatherDataList = weatherData.list else {
                         self.displayAlert(with: "Désolé, il n'y a pas de données")
                        return
                    }
                    self.firstCityTemperature.text = String(weatherDataList[0].main.temp) + " °C"
                    self.secondCityTemperature.text = String(weatherDataList[1].main.temp) + " °C"

                } else {
                    self.displayAlert(with: error)
                }
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
// TODO: Changer les message d'alerte en francais
// TODO: Mettre commentaires
