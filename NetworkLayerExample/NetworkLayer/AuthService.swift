//
//  AuthService.swift
//  NetworkLayerExample
//
//  Created by Canh Tran Wizeline on 8/7/19.
//  Copyright © 2019 Canh Tran. All rights reserved.
//

import Foundation

enum AuthServiceEndpoint: Endpoint {
    
    case login
    case logout
    
    // MARK: Confirm protocol Endpoint
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        switch self {
        case .login: return "/users/authenticate"
        case .logout: return "user/logout"
        }
    }
    
    var parameters: JSON? {
        return nil
        /// Use custom JSON parameters here if we don't use Encodable object
    }
    
    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
}


/// Represent the AuthService APIs as a contract for the concrete type to implement
protocol AuthService {
    func login(loginRequest: LoginRequest, completion: @escaping(Result<User, NetworkError>) -> Void)
}

struct AuthServiceRepository: AuthService {
    
    /// Login service for retrive user information based on username and password
    ///
    /// - Parameters:
    ///   - loginRequest: login request object as the parameters
    ///   - completion: result as User/Error
    func login(loginRequest: LoginRequest, completion: @escaping(Result<User, NetworkError>) -> Void) {
        let endPoint: AuthServiceEndpoint = .login
        let requestBody = endPoint.parametersToHttpBody(loginRequest)
        let networkClient = NetworkClient()
        
        guard let request = networkClient.buildRequest(from: endPoint, requestBody: requestBody) else { completion(.failure(.unableToGenerateURLRequest)); return }
        networkClient.fetch(request: request, type: User.self, completion: completion)
    }
}
