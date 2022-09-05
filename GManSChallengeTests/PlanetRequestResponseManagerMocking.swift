//
//  PlanetRequestResponseManagerMocking.swift
//  GManSChallengeTests
//
//  Created by Bhuvanendra Pratap Maurya on 04/09/22.
//

import XCTest
@testable import GManSChallenge

final class GManSRequestResponseManagerGetPlanetSuccess: RequestResponseProtocol {
    let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func sendRequest(apiCall: GManSHttpAPI,
                     onSuccess: @escaping(_ statusCode: Int, _ responseData: Data, _ headersFields: [AnyHashable: Any]?) -> (),
                     onFailure: @escaping(_ error: GManSError, _ responseData: Data?) -> ()) {
        guard let asset = NSDataAsset(name: "PlanetData") else {
            fatalError("Missing data asset: Get Planet Response")
        }
        let data = asset.data
        onSuccess(200, data, nil)
    }
}

final class GManSRequestResponseManagerGetPlanetsFailure: RequestResponseProtocol {
    let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func sendRequest(apiCall: GManSHttpAPI,
                     onSuccess: @escaping(_ statusCode: Int, _ responseData: Data, _ headersFields: [AnyHashable: Any]?) -> (),
                     onFailure: @escaping(_ error: GManSError, _ responseData: Data?) -> ()) {
        var apiURLStr = "\(baseUrl)\(apiCall.path)"
        if let parameters = apiCall.parameters {
            apiURLStr = apiURLStr.append(parameters)
        }
        let apiURL = URL(string: apiURLStr.trimmingCharacters(in: .whitespaces))
        guard let finalURL = apiURL else {
            onFailure(GManSError(), nil)
            return
        }
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = apiCall.method.rawValue
        if let headers = apiCall.headers {
            urlRequest.headers = headers
        }
        do {
            urlRequest.httpBody = try apiCall.body()
        } catch {
            print("Body encoding failed error: \(error.localizedDescription)")
        }
        let error = GManSError(code: 400, message: "Failed with 400")
        onFailure(error, nil)
    }
}
