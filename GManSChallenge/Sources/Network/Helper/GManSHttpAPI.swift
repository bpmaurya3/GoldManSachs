//
//  GManSHttpAPI.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import Alamofire

protocol GManSHttpAPI: CustomStringConvertible {

    /// This is the path of the API call that gets added to the base URL
    var path: String { get }

    /// Type of method that needs to be used for API call
    var method: HTTPMethod { get }

    /// All the headers that needs to be used in the API call
    var headers: HTTPHeaders? { get }

    /// All the parameterrs that need to added to URL as query parrameters
    var parameters: Parameters? { get }

    /// Parameters that needs to be passed in body of API call
    var bodyParameters: [String: Any]? { get }

    /// The codes that needs to be treated as success
    var successCodes: [Int] { get }

    /// The codes that needs to be treated as failures
    var failureCodes: [Int] { get }

    /// The function which constructs the body in required format for the API
    func body() throws -> Data?
}

extension GManSHttpAPI {
    var description: String {
        "path: \(self.path), method: \(self.method), headers: \(String(describing: self.headers)), parameters: \(String(describing: self.parameters)), bodyParameters: \(String(describing: self.bodyParameters))"
    }
}

extension GManSHttpAPI {
    func encodedJsonData(data: Any) throws -> Data? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed) else {
            return nil
        }
        let jsonString = String(data: jsonData, encoding: .utf8)
        return jsonString?.data(using: .utf8)
    }
}
