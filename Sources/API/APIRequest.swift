//
//  File.swift
//  
//
//  Created by Noah Peeters on 16.03.21.
//

import Foundation

public protocol APIRequest {
    associatedtype Response: APIResponse

    static var path: String { get }
}
