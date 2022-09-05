//
//  ColorPalette.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 02/09/22.
//

import UIKit

enum ColorPalette: String {
    case gray6
    case white
    case black
    case clear

    private var bundle: Bundle {
        Bundle(for: LocalizedStrings.self)
    }

    var color: UIColor {
        switch self {
        case .clear:
            return UIColor.clear
        default:
            return UIColor(named: self.rawValue, in: bundle, compatibleWith: nil)!
        }
    }

    var cgColor: CGColor {
        self.color.cgColor
    }
}
