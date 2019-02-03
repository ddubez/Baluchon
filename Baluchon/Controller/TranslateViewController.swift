//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by David Dubez on 20/01/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    // MARK: - PROPERTIES

    var imputTextView = UITextView()
    var resultTextView = UITextView()
    var translationWay = true
    var translationSource = ""
    var translationTarget = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBOULETS

    @IBOutlet weak var firstTextView: UITextView!
    @IBOutlet weak var secondTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var upToDownButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var downToUpButton: UIButton!

    // MARK: - IBACTIONS
    @IBAction func didTapGoogleAttribution(_ sender: UIButton) {
        displayGoogleAttribution()
    }
    @IBAction func didTapTranlateUpToDown(_ sender: UIButton) {
        translationWay = true
        updateTranslationTextText()
    }
    @IBAction func didTapClearText(_ sender: UIButton) {
        clearText()
    }
    @IBAction func didTapTranslateDownToUp(_ sender: UIButton) {
        translationWay = false
        updateTranslationTextText()
    }

    // MARK: - FUNCTION
    private func toggleTextField(input: UITextView,
                                 result: UITextView,
                                 working: Bool) {
        if working {
            input.backgroundColor = UIColor.gray
            result.backgroundColor = #colorLiteral(red: 0.8560757637, green: 0.8264992833, blue: 0.7923122048, alpha: 1)
            result.text = "..."
        } else {
            input.backgroundColor = UIColor.white
            result.backgroundColor = UIColor.white
            result.text = ""
        }
        input.isEditable = !working
        result.isEditable = !working
        upToDownButton.isHidden = working
        downToUpButton.isHidden = working
        clearButton.isHidden = working
        activityIndicator.isHidden = !working

    }

    private func updateTranslationTextText() {
        if translationWay == true {
            imputTextView = firstTextView
            resultTextView = secondTextView
            translationSource = "fr"
            translationTarget = "en"
        } else {
            imputTextView = secondTextView
            resultTextView = firstTextView
             translationSource = "en"
            translationTarget = "fr"
        }
        toggleTextField(input: imputTextView,
                        result: resultTextView,
                        working: true)

        TranslationService.shared.getTranslation (
                    textToTranslate: imputTextView.text,
                    source: translationSource,
                    target: translationTarget) {(success, translation, error) in
            self.toggleTextField(input: self.imputTextView,
                                 result: self.resultTextView,
                                 working: false)

            if success == true, let translation = translation {
                self.resultTextView.text = "\(translation.data!.translations[0].translatedText)"
            } else {
                self.displayAlert(with: error)
            }
        }
    }

    private func clearText() {
        firstTextView.text = ""
        secondTextView.text = ""
    }
}

// MARK: - User KeyBoard Data Entry
extension TranslateViewController: UITextViewDelegate {

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        firstTextView.resignFirstResponder()
        secondTextView.resignFirstResponder()
        return true
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        firstTextView.resignFirstResponder()
        secondTextView.resignFirstResponder()
    }
}
// MARK: - Alert
extension TranslateViewController {
    func displayAlert(with message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func displayGoogleAttribution() {
        let message =   """
                        CE SERVICE PEUT CONTENIR DES TRADUCTIONS FOURNIES PAR GOOGLE.
                        GOOGLE DÉCLINE TOUTE RESPONSABILITÉ EXPLICITE OU IMPLICITE CONCERNANT LES TRADUCTIONS
                        Y COMPRIS TOUTE GARANTIE D'EXACTITUDE ET DE FIABILITÉ, AINSI QUE TOUTE GARANTIE
                        IMPLICITE DE QUALITÉ MARCHANDE, D'ADÉQUATION À UN USAGE PARTICULIER ET DE CONFORMITÉ
                        """
        let alert = UIAlertController(title: "Avertissement", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
// TODO: Mettre commentaires
// TODO: refactor ??
// TODO: Voir si il faut mettre le text should return si on a mis la fonction textfielddidendediting ?? /// changer le comportement de la touche entrée
// TODO: - mouvement du texte vers le haut pour clavier du bas
// TODO: sur le petit format le texte traduction se cache
// TODO: - voir poour faire comme une sorte de message instantanné
