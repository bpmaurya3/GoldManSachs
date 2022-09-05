//
//  PlanetNetworkTransaction.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import Foundation

final class PlanetNetworkTransaction {

    var requestManager: RequestResponseProtocol

    init(baseUrl: String) {
        self.requestManager = GManSRequestResponseManager(baseUrl: baseUrl)
    }

    func getPlanet(date: String?,
                   onSuccess: @escaping (_ statusCode: Int, _ responseData: Data, _ headersFields: [AnyHashable: Any]?) -> (),
                   onFailure: @escaping (_ error: GManSError, _ responseData: Data?) -> Void) {
        let apiCallType = PlanetHttpAPI.getPlanet(date: date)
        self.requestManager.sendRequest(apiCall: apiCallType, onSuccess: onSuccess, onFailure: onFailure)
    }
}
