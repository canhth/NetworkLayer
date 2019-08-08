//
//  User.swift
//  NetworkLayerExample
//
//  Created by Canh Tran Wizeline on 8/7/19.
//  Copyright © 2019 Canh Tran. All rights reserved.
//

import Foundation

// A type represents a UserResult
struct User: Decodable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let createdAt: Int
}
