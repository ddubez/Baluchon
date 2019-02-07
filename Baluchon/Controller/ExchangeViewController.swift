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
// TODO: Changer les message d'alerte en francais
// TODO: Mettre commentaires
// TODO: - UI test à faire
