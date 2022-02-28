//
//  URL+QueryItems.swift
//  
//
//  Created by Todd Bowden on 2/28/22.
//

import Foundation

public extension URL {
    func append(queryItems: [URLQueryItem]?) throws -> URL {
        guard let queryItems = queryItems else { return self }
        guard !queryItems.isEmpty else { return self }
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            throw Error.cannotGetURLCompoents
        }
        if components.queryItems == nil {
            components.queryItems = [URLQueryItem]()
        }
        components.queryItems?.append(contentsOf: queryItems)
        guard let url = components.url else {
            throw Error.invalidQueryItems
        }
        return url
    }
}
