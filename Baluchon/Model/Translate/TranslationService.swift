//
//  TranslationService.swift
//  Baluchon
//
//  Created by David Dubez on 01/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

class TranslationService {
    // network request for retrieve translation data in Translation Class

    // MARK: - PROPERTIES
    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session = session
    }

    static var shared = TranslationService()
    private init() {}

    private static let urlString = "https://translation.googleapis.com/language/translate/v2"

    private static let translationUrl = URL(string: urlString)!

    private var task: URLSessionDataTask?

    // MARK: - FUNCTIONS
    func getTranslation(textToTranslate: String,
                        source: String,
                        target: String,
                        callBack: @escaping (Bool, Translation?, String) -> Void) {
        let request = createTranslationRequest(textToTranslate: textToTranslate, source: source, target: target)

        task?.cancel()

        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil, "error in data")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil, "error in statusCode")
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Translation.self, from: data) else {
                    callBack(false, nil, "error in JSONDecoder")
                    return
                }
                guard responseJSON.error == nil else {
                    callBack(false, nil, (responseJSON.error?.message)!)
                    return
                }
                let translation = responseJSON
                callBack(true, translation, "")
            }
        }
        task?.resume()
    }

    private func createTranslationRequest(textToTranslate: String, source: String, target: String) -> URLRequest {
        var request = URLRequest(url: TranslationService.translationUrl)
        request.httpMethod = "POST"

        let body =  "key=" + ServicesKey.apiKeyTranslate +
                    "&source=" + source +
                    "&target=" + target +
                    "&q=" + textToTranslate
        request.httpBody = body.data(using: .utf8)

        return request
    }
}
