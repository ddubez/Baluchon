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
    }

    // MARK: - IBOUTLET
    @IBOutlet weak var baseRateTextField: UITextField!
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var baseRateActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var rateActivityIndicator: UIActivityIndicatorView!

     // MARK: - FUNCTION

}

// MARK: - User KeyBoard Data Entry
extension ExchangeViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == baseRateTextField {
            baseRateTextField.backgroundColor = UIColor.gray
            baseRateTextField.isEnabled = false
            rateTextField.isHidden = true
            rateActivityIndicator.isHidden = false

            ForexService.shared.getForex { (success, forex, error) in
                self.baseRateTextField.backgroundColor = UIColor.white
                self.baseRateTextField.isEnabled = true
                self.rateTextField.isHidden = false
                self.rateActivityIndicator.isHidden = true

                if success == true, let forex = forex {
                    guard let amountToConvert = Double(self.baseRateTextField.text!) else {
                        self.displayAlert(with: "enter a number !")
                        return
                    }
                    let amountConverted = amountToConvert * forex.rates!.USD
                    self.rateTextField.text = "\(amountConverted)"
                } else {
                    self.displayAlert(with: error)
                }
            }
        } else if textField == rateTextField {
            rateTextField.backgroundColor = UIColor.gray
            baseRateTextField.isHidden = true
            baseRateActivityIndicator.isHidden = false

            ForexService.shared.getForex { (success, forex, error) in
                self.rateTextField.backgroundColor = UIColor.white
                self.rateTextField.isEnabled = true
                self.baseRateTextField.isHidden = false
                self.baseRateActivityIndicator.isHidden = true

                if success == true, let forex = forex {
                    guard let amountToConvert = Double(self.rateTextField.text!) else {
                        self.displayAlert(with: "enter a number !")
                        return
                    }
                    let amountConverted = amountToConvert / forex.rates!.USD
                    self.baseRateTextField.text = "\(amountConverted)"
                } else {
                    self.displayAlert(with: error)
                }
            }
        }
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        baseRateTextField.resignFirstResponder()
        rateTextField.resignFirstResponder()
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

// TODO: - gerer les différentes messages erreur (modifier les texte dans le modele
// TODO: - refactoriser
