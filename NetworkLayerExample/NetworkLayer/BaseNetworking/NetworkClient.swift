//
//  NetworkClient.swift
//  CTNetworking
//
//  Created by Canh Tran Wizeline on 5/5/19.
//  Copyright © 2019 Canh Tran. All rights reserved.
//

import Foundation

/// A definition of a NetworkClient
protocol NetworkRequestable {
    init(session: URLSession)
    func fetch<T: Decodable>(request: URLRequest,
                             type: T.Type,
                             completion: @escaping (Result<T, NetworkError>) -> Void)
}

/// A type represents network client
final class NetworkClient: NetworkRequestable {
    
    typealias NetworkClientResponse<T> = (Result<T, NetworkError>) -> Void
    
    private let session: URLSession
    
    /// Creates an instance of network client
    ///
    /// - Parameter session: The URLSession that coordinates a group of related network data transfer tasks
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    /// Fetches a network request with a relevant decodable type to decode the response.
    ///
    /// - Parameters:
    ///   - request: The request to fetch
    ///   - decode: The decode closure that expects a `Decodable` object and returns a relevant type
    ///   - completion: The completion handler of the request
    func fetch<T>(request: URLRequest,
                  type: T.Type,
                  completion: @escaping NetworkClientResponse<T>) where T: Decodable {
        
        let task = session.dataTask(with: request) { data, response, _ in
            guard let data = data,
                let httpResponse = response as? HTTPURLResponse,
                200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.invalidResponse)); return
            }
            
            do {
                let genericModel = try JSONDecoder().decode(T.self, from: data)
                completion(.success(genericModel))
            } catch {
                completion(.failure(.badDeserialization))
            }
        }
        task.resume()
    }
    
    /// Fetches a network request then parse the response with `JSONSerialization`
    ///
    /// - Parameters:
    ///   - request: The request to fetch
    ///   - completion: The completion handler of the request
    func fetch(request: URLRequest, completion: @escaping(JSON?, NetworkError?) -> Void) {
        let task = session.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion(nil, .emptyResponse)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                completion(json, nil)
            } catch {
                completion(nil, .badDeserialization)
            }
        }
        task.resume()
    } 
}

extension NetworkClient {
    /// Build an URLRequest with HTTPBody
    ///
    /// - Parameters:
    ///   - endpoint: An instance of `Endpoint`
    ///   - requestHeaders: The info of request's HTTP header
    ///   - requestBody: The request body
    /// - Returns: An URLRequest
    func buildRequest(from endpoint: Endpoint,
                      requestBody: Data?) -> URLRequest? {
        guard let url = endpoint.urlComponents?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers.forEach { request.addValue( $0.value, forHTTPHeaderField: $0.key) }
        request.httpBody = requestBody
        return request
    } 
}
