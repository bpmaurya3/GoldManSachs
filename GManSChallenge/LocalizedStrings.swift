//
//  LocalizedStrings.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import Foundation

class LocalizedStrings {
    static let bundle = Bundle(for: LocalizedStrings.self)

    struct Global {
        static let noInternet = NSLocalizedString("global.noInternet", bundle: bundle, comment: "")
        static let networkConnectionLost = NSLocalizedString("global.error.networkConnectionLost", bundle: bundle, comment: "")
        static let cancel = NSLocalizedString("global.cancel", bundle: bundle, comment: "")
        static let done = NSLocalizedString("global.done", bundle: bundle, comment: "")
    }

    struct PictureList {
        static let navTitle = NSLocalizedString("pictureList.navTitle", bundle: bundle, comment: "")
    }
}
