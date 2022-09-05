//
//  GManSSessionManager.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import Alamofire

final class GManSSessionManager: Session {
    static let sharedDefault: Session = {
        var sessionManager: Session = Session()
        sessionManager.session.configuration.httpMaximumConnectionsPerHost = 5
        sessionManager.session.configuration.httpShouldUsePipelining = true
        sessionManager.session.configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        sessionManager.session.configuration.timeoutIntervalForRequest = 15
        return sessionManager
    }()
}
