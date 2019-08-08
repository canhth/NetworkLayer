//
//  LoginRequest.swift
//  NetworkLayerExample
//
//  Created by Canh Tran Wizeline on 8/7/19.
//  Copyright © 2019 Canh Tran. All rights reserved.
//

import Foundation

/// A type represents a Login parameters
struct LoginRequest: Encodable {
    let username: String
    let password: String
}
