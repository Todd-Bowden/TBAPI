//
//  File.swift
//  
//
//  Created by Todd Bowden on 2/28/22.
//

import Foundation

public extension URLRequest {
    
    mutating func set(headers: [String:String]?) {
        guard let headers = headers else { return }
        guard !headers.isEmpty else { return }
        for (header, value) in headers {
            self.setValue(value, forHTTPHeaderField: header)
        }
    }
}
