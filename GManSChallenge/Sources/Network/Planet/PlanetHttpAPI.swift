//
//  PlanetHttpAPI.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import Alamofire

enum PlanetHttpAPI: GManSHttpAPI {
    case getPlanet(date: String?)

    var path: String {
        switch self {
        case .getPlanet:
            return String(format: "/planetary/apod")
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPlanet:
            return .get
        }
    }

    var headers: HTTPHeaders? {
        let standardHeaders: HTTPHeaders = ["Content-Type": "application/json"]
        switch self {
        case .getPlanet:
            return standardHeaders
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getPlanet(let date):
            let startDate = date ?? "2022-08-01"
            let endDate = date ?? Date().getDateInString()
            return ["api_key": Constants.APIKey.key,
                    "start_date": startDate,
                    "end_date": endDate,
                    "thumbs": true]
        }
    }

    var bodyParameters: [String : Any]? {
        switch self {
        case .getPlanet:
            return nil
        }
    }

    func body() throws -> Data? {
        nil
    }

    var successCodes: [Int] {
        [200, 202, 204]
    }

    var failureCodes: [Int] {
        [400, 404, 500, 503]
    }
}
