//
//  Dictionary.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 02/09/22.
//

import Foundation

extension Dictionary {

    func union(_ dictionary: Dictionary) -> Dictionary {
        var newDict = dictionary
        newDict.unionInPlace(self)
        return newDict
    }

    mutating func unionInPlace(_ dictionary: Dictionary) {
        dictionary.forEach { self.updateValue($1, forKey: $0) }
    }
}
