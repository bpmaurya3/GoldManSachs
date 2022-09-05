//
//  GManSError.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import Foundation

struct GManSError: Error, LocalizedError, CustomStringConvertible {
    let code: GManSHTTPStatusCode
    var message: String?

    init() {
        self.code = GManSHTTPStatusCode.localGenericServerError
        self.message = ""
    }

    init(code: Int, message: String?) {
        self.code = GManSHTTPStatusCode(rawValue: code) ?? GManSHTTPStatusCode.localGenericServerError
        self.message = message
    }

    var description: String {
        "Error Code: \(self.code), message: \(String(describing: self.message))"
    }
}
