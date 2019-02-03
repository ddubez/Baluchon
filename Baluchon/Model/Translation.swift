//
//  Translation.swift
//  Baluchon
//
//  Created by David Dubez on 31/01/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

struct Translation: Decodable {
    var data: Data?
    var error: Error?

    struct Data: Decodable {
        var translations: [Translations]
    }

    struct Translations: Decodable {
        var translatedText: String
    }

    struct Error: Decodable {
        var code: Int
        var message: String
        var errors: Errors
        var status: String
    }

    struct Errors: Decodable {
        var message: String
        var domaine: String
        var reason: String
    }
}
// TODO: Mettre commentaires
