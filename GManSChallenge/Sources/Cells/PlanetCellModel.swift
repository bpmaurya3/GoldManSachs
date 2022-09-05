//
//  PlanetCellModel.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 02/09/22.
//

import Foundation

enum MediaType: String {
    case image
    case video
}

struct PlanetCellModel {
    let title: String
    let date: String
    let explanation: String
    let imageUrl: String
    let thumbUrl: String
    let mediaType: MediaType
    var isFavourite: Bool = false

    init(from planet: Planet) {
        self.title = planet.title ?? ""
        self.date = planet.addedDate ?? ""
        self.explanation = planet.explanation ?? ""
        self.imageUrl = planet.imageUrl ?? ""
        self.thumbUrl = planet.thumbUrl ?? ""
        self.mediaType = MediaType(rawValue: planet.mediaType ?? "") ?? .image
        self.isFavourite = planet.isFavourite
    }
}
