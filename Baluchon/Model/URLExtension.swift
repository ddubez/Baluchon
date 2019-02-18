//
//  URLExtension.swift
//  Baluchon
//
//  Created by David Dubez on 15/02/2019.
//  Copyright © 2019 David Dubez. All rights reserved.
//

import Foundation

extension URL {
    // pass Dictionary in URL query

    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {URLQueryItem(name: $0.0, value: $0.1)}
        return components?.url
    }
}
