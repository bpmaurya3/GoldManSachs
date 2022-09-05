//
//  String.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import Alamofire

extension String {
    /// Method to append all keys and values of a Dictionary and return a string
    /// - Parameter parameters: this is a dictionary of parameters
    /// - Returns: A string with all keys and values appended
    mutating func append(_ parameters: Parameters) -> String {
        for (index, parameter) in parameters.enumerated() {
            if index == 0 {
                self += "?\(parameter.key)=\(parameter.value)"
            } else {
                self += "&\(parameter.key)=\(parameter.value)"
            }
        }
        return self
    }
}
