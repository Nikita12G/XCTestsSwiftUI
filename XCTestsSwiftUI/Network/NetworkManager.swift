//
//  NetworkManager.swift
//  XCTestEx
//
//  Created by Никита Гуляев on 14.08.2024.
//

import Foundation

import Foundation

class NetworkManager {
    
    // MARK: - GET Request
    func get(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        logRequest(request)
        performRequest(request, completion: completion)
    }
    
    // MARK: - POST Request
    func post(url: URL, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        logRequest(request)
        performRequest(request, completion: completion)
    }
    
    // MARK: - PUT Request
    func put(url: URL, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = body
        logRequest(request)
        performRequest(request, completion: completion)
    }
    
    // MARK: - DELETE Request
    func delete(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        logRequest(request)
        performRequest(request, completion: completion)
    }
    
    // MARK: - Private Helper Method
    private func performRequest(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "com.NetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
    
    // MARK: - Logging Method
    private func logRequest(_ request: URLRequest) {
        print("⏩ Request Method: \(request.httpMethod ?? "Unknown")")
        print("⏩ Request URL: \(request.url?.absoluteString ?? "Unknown URL")")
        
        if let headers = request.allHTTPHeaderFields {
            print("⏩ Request Headers: \(headers)")
        }
        
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("⏩ Request Body: \(bodyString)")
        }
    }
}
