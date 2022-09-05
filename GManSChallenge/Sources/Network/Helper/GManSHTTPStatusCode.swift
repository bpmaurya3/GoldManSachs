//
//  GManSHTTPStatusCode.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import Foundation

enum GManSHTTPStatusCode: Int, Error {
    // localGenericServerError: When app gets an un-handled/un-known error
    case localGenericServerError = 999
    // timeoutError: Response when the request gets timed out
    case timeoutError = 0
    // ok: Standard response for successful HTTP requests.
    case ok = 200
    // badRequest: Response for Mandatory parameter missing invalid grantType/OTP channel.
    case badRequest = 400
    // unauthorized: Response for invalid token or refresh token
    case unauthorized = 401
    // forbidden: Response for invalid scope/cookie/deviceId/exceeds otp attempts
    case forbidden = 403
    // notFound: Response for user not found
    case notFound = 404
    // serverError: Response for intenal server error
    case serverError = 500
    // serviceUnavailable: Response when server is not available
    case serviceUnavailable = 503
    // noInternet: Response when there is no internet connection
    case noInternet = 9_991
}
