//
//  Error.swift
//  
//
//  Created by Todd Bowden on 2/28/22.
//

import Foundation

public enum Error: Swift.Error {
    case invalidURL(String)
    case invalidQueryItems
    case cannotGetURLCompoents
    case noResponseCode
    case responseCode(Int)
}
