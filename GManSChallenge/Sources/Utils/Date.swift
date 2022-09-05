//
//  Date.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 04/09/22.
//

import Foundation

extension Date {
    func getDateInString()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
