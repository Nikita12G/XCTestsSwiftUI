//
//  NetworkManagerTests.swift
//  XCTestExTests
//
//  Created by Никита Гуляев on 14.08.2024.
//

import XCTest
@testable import XCTestsSwiftUI

final class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var mockURLSession: URLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        networkManager = NetworkManager()

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        mockURLSession = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {
        networkManager = nil
        mockURLSession = nil
        try super.tearDownWithError()
    }

    func testGetRequestSuccess() throws {
        guard let url = URL(string: "https://reqres.in/api/users/2") else { return }
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        let expectation = self.expectation(description: "GET Request")
        
        networkManager.get(url: url) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPostRequestSuccess() throws {
        guard let url = URL(string: "https://reqres.in/api/register") else { return }
        let requestBody = """
        {
            "email": "eve.holt@reqres.in",
            "password": "pistol"
        }
        """.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            return (response, Data())
        }
        
        let expectation = self.expectation(description: "POST Request")
        
        networkManager.post(url: url, body: requestBody) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPutRequestSuccess() throws {
        guard let url = URL(string: "https://reqres.in") else { return }
        let requestBody = "Test Body".data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, "PUT")
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        let expectation = self.expectation(description: "PUT Request")
        
        networkManager.put(url: url, body: requestBody) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDeleteRequestSuccess() throws {
        guard let url = URL(string: "https://reqres.in") else { return }
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, "DELETE")
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        let expectation = self.expectation(description: "DELETE Request")
        
        networkManager.delete(url: url) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
