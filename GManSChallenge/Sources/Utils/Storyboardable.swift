//
//  Storyboardable.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 02/09/22.
//

import UIKit

enum Storyboardable<ViewController> {
    case main

    var storyboardName: String {
        switch self {
        case .main:
            return Constants.Storyboard.main
        }
    }
    
    var instantiate: ViewController {
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: BundleClass.bundle)
        return storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
    }
}

class BundleClass {
    static let bundle = Bundle(for: BundleClass.self)
}
