//
//  ExchangeViewController.swift
//  Baluchon
//
//  Created by David Dubez on 20/01/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create historic Bar Chart
        setDataEntries { (dataEntries) in
            self.historicBarChart.dataEntries = dataEntries
        }
    }
    
    // MARK: - PROPERTIES
    var conversion = Conversion()
    var imputTextField = UITextField()
    var resultTextFied = UITextField()
    var imputActivityIndicator = UIActivityIndicatorView()
    var resultActivityIndicator = UIActivityIndicatorView()

    // MARK: - IBOUTLET
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var firstActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var secondActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var historicBarChart: BasicBarChart!
    
     // MARK: - FUNCTION
    private func toggleTextField(input: UITextField,
                                 result: UITextField,
                                 resultActivityIndicateur: UIActivityIndicatorView,
                                 working: Bool) {
        if working {
            input.backgroundColor = UIColor.gray
        } else {
            input.backgroundColor = UIColor.white
        }
        input.isEnabled = !working
        result.isHidden = working
        secondActivityIndicator.isHidden = !working
    }

    private func updateAmountText() {
        if conversion.way == .normal {
            imputTextField = firstTextField
            resultTextFied = secondTextField
            imputActivityIndicator = firstActivityIndicator
            resultActivityIndicator = secondActivityIndicator
        } else {
            imputTextField = secondTextField
            resultTextFied = firstTextField
            imputActivityIndicator = secondActivityIndicator
            resultActivityIndicator = firstActivityIndicator
        }
        toggleTextField(input: imputTextField,
                        result: resultTextFied,
                        resultActivityIndicateur: resultActivityIndicator,
                        working: true)

        ForexService.shared.getForex { (success, forex, error) in
            self.toggleTextField(input: self.imputTextField,
                                 result: self.resultTextFied,
                                 resultActivityIndicateur: self.resultActivityIndicator,
                                 working: false)

            if success == true, let forex = forex {
                guard let amountToConvert = Double(self.imputTextField.text!) else {
                    self.displayAlert(with: "enter a number !")
                    return
                }
                self.conversion.convert(amountToConvert, rate: forex.rates!.USD)
                self.resultTextFied.text = "\(self.conversion.amountConverted)"
            } else {
                self.displayAlert(with: error)
            }
        }
    }
}

// MARK: - User KeyBoard Data Entry
extension ExchangeViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == firstTextField {
            conversion.way = .normal
            updateAmountText()
        } else if textField == secondTextField {
            conversion.way = .reserse
            updateAmountText()
        }
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        firstTextField.resignFirstResponder()
        secondTextField.resignFirstResponder()
    }
}

// MARK: - Alert
extension ExchangeViewController {
    func displayAlert(with message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - BarChart
extension ExchangeViewController {
    func setDataEntries(completionHandler:@escaping (([BarEntry]) -> Void)) {
        let colors = [#colorLiteral(red: 0.08462960273, green: 0.5212771297, blue: 0.5258666277, alpha: 1), #colorLiteral(red: 0.7704077363, green: 0.3681732416, blue: 0.2172614336, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.8777174354, green: 0.6299223304, blue: 0.1042385176, alpha: 1), #colorLiteral(red: 0.2566062808, green: 0.1277478337, blue: 0.2579344213, alpha: 1), #colorLiteral(red: 0.1392979622, green: 0.7078385353, blue: 0.9096518159, alpha: 1), #colorLiteral(red: 0.7746306062, green: 0.6284463406, blue: 0.450842917, alpha: 1)]
        var result: [BarEntry] = []
        
        HistoricalForexService.shared.getTimeSerie { (success, dataEntries, error) in
            if success == true, let dataEntries = dataEntries {
                let maxValue = dataEntries.values.max()!
                let minValue = dataEntries.values.min()!
                let sortedDataEntries = dataEntries.sorted { $0.key < $1.key }
                var barCount = 0
                
                for (date, value) in sortedDataEntries {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let trueDate = formatter.date(from: date)
                    formatter.dateFormat = "dd/MM"
                    let dateToDisplay = formatter.string(from: trueDate!)
                    
                    let height: Float = Float((value - minValue) / (maxValue - minValue))
                    result.append(BarEntry(color: colors[barCount], height: height, textValue: "\(round(value * 1000) / 1000)", title: dateToDisplay))
                    barCount += 1
                }
                completionHandler(result)
            } else {
                self.displayAlert(with: error)
            }
        }
    }
}
// TODO: Changer les message d'alerte en francais
// TODO: Mettre commentaires

