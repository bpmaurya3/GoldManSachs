//
//  GManSRequestResponseManager.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import Alamofire

protocol RequestResponseProtocol: AnyObject {
    var baseUrl: String { get }

    func sendRequest(apiCall: GManSHttpAPI,
                     onSuccess: @escaping(_ statusCode: Int, _ responseData: Data, _ headersFields: [AnyHashable: Any]?) -> (),
                     onFailure: @escaping(_ error: GManSError, _ responseData: Data?) -> ())
}

final class GManSRequestResponseManager: RequestResponseProtocol {
    var baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func sendRequest(apiCall: GManSHttpAPI, onSuccess: @escaping (Int, Data, [AnyHashable : Any]?) -> (), onFailure: @escaping (GManSError, Data?) -> ()) {
        guard let networkManager = NetworkReachabilityManager.default, networkManager.isReachable else {
            onFailure(GManSError(code: GManSHTTPStatusCode.noInternet.rawValue, message: LocalizedStrings.Global.noInternet), nil)
            return
        }
        guard var urlRequest = self.generateURLRequest(apiCall: apiCall) else {
            onFailure(GManSError(), nil)
            return
        }
        do {
            urlRequest.httpBody = try apiCall.body()
        } catch {
            print("Body encoding failed error: \(error.localizedDescription)")
        }

        let dataRequest = GManSSessionManager.sharedDefault.request(urlRequest)
        dataRequest.validate(statusCode: apiCall.successCodes)
        self.handleResponse(dataRequest, apiCall: apiCall, onSuccess: onSuccess, onFailure: onFailure)
    }

    func generateURLRequest(apiCall: GManSHttpAPI) -> URLRequest? {
        var apiURLStr = "\(baseUrl)\(apiCall.path)"
        if let parameters = apiCall.parameters {
            apiURLStr = apiURLStr.append(parameters)
        }
        let apiURL = URL(string: apiURLStr.trimmingCharacters(in: .whitespaces))
        guard let finalURL = apiURL else {
            print("failed to create request url \(String(describing: apiURL?.absoluteString))")
            return nil
        }
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = apiCall.method.rawValue
        if let headers = apiCall.headers {
            urlRequest.headers = headers
        }
        return urlRequest
    }

    // MARK: Response

    func handleResponse(_ request: DataRequest,
                        apiCall: GManSHttpAPI,
                        onSuccess: @escaping(_ statusCode: Int, _ responseData: Data, _ headersFields: [AnyHashable: Any]?) -> (),
                        onFailure: @escaping(_ error: GManSError, _ responseData: Data?) -> ()) {
        request.responseData(emptyResponseCodes: []) { response in
            autoreleasepool {
                HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
            }
            guard let statusCode = response.response?.statusCode else {
                print("NetWork Response Failed without status code \(response)")
                if let error = response.error {
                    print("Error:: \(error)")
                    if let errorCode = (error.underlyingError as? URLError)?.code,
                       errorCode == .notConnectedToInternet || errorCode == .networkConnectionLost {
                        onFailure(GManSError(code: errorCode.rawValue, message: LocalizedStrings.Global.networkConnectionLost), nil)
                    } else {
                        onFailure(GManSError(code: error.responseCode ?? 0, message: error.localizedDescription), nil)
                    }
                } else {
                    print("No eror::")
                    onFailure(GManSError(), nil)
                }
                return
            }

            print("NetWork Response \(String(describing: response.response))")

            switch response.result {
            case .success(let data):
                print("Response: \(String(describing: String(data: data, encoding: .utf8)))")
                onSuccess(statusCode, data, response.response?.allHeaderFields)
            case .failure(let error):
                print("Failed with status code: \(statusCode), localizedDescription: \(error.localizedDescription)")
                print("Response data \(String(data: response.data ?? Data(), encoding: .utf8) ?? "")")
                let error = GManSError(code: statusCode, message: "")
                onFailure(error, response.data)
            }
        }
    }
}
