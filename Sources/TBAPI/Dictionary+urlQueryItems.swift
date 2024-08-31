//
//  Dictionary+urlQueryItems.swift
//
//
//  Created by Todd Bowden on 8/31/24.
//

import Foundation

public extension Dictionary where Key == String, Value == Any? {
    var urlQueryItems: [URLQueryItem]? {
        var queryItems: [URLQueryItem] = []
        for (key, value) in self {
            if let value {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
        }
        guard queryItems.count > 0 else { return nil }
        return queryItems
    }
}
