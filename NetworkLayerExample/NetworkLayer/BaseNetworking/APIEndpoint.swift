//
//  APIEndpoint.swift
//  CTNetworking
//
//  Created by Canh Tran Wizeline on 5/5/19.
//  Copyright © 2019 Canh Tran. All rights reserved.
//

import Foundation 

typealias JSON = [String: Any]
typealias HTTPHeaders = [String: String]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum Environment: String {
    case staging = "stage"
    case production = "production"
    
    var value: String {
        return self.rawValue
    }
}

/// A definition of an valid endpoint to create a URLRequest
protocol Endpoint {
    var base: String { get }
    var environment: Environment { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: JSON { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    
    var base: String {
        return "https://www.wtwmexico-qa.com.mx/WSApiMovilQA/api"
    }
    
    var headers: HTTPHeaders {
        return ["Accept": "application/json"]
    }
    
    /// Default environment
    var environment: Environment {
        return .staging
    }
    
    /// Default parameters
    var parameters: JSON {
        return ["": ""]
    }
    
    /// A computed property to return a instance of a URLComponents
    var urlComponents: URLComponents? {
        guard var url = URL(string: base) else { return nil }
        url.appendPathComponent(environment.value)
        url.appendPathComponent(path)
        
        return URLComponents(url: url, resolvingAgainstBaseURL: false)
    }
    
    /// Converts a Encodable object into Data to use as the HTTPBody
    ///
    /// - Parameter parameters: The parameters to be converted
    /// - Returns: The converted data
    func parametersToHttpBody<T: Encodable>(_ parameters: T) -> Data? {
        let data = try? JSONEncoder().encode(parameters)
        return data
    }
    
    /// Converts a JSON object into Data to use as the HTTPBody
    ///
    /// - Parameter parameters: The parameters to be converted
    /// - Returns: The converted data
    func parametersToHttpBody(_ parameters: JSON) -> Data? {
        let data = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        return data
    }
}
