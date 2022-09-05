//
//  PlanetDao.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 03/09/22.
//

import Foundation

// Manage the DB operation
struct PlanetDao {
    // Get Planet from DB for a image url
    func getPlanetFrom(imageUrl: String) -> Planet? {
        let predicate = NSPredicate(format: "imageUrl = %@", imageUrl)
        let planets = PersistentManager.shared.fetch(Planet.self, predicate: predicate)
        return planets.first
    }

    // Add or update parsed planet model into DB
    func addOrUpdate(parsedModel: GManSPlanet,
                     shouldSave: Bool = true) -> Planet {
        var planetEntity: Planet
        if let existingTag = self.getPlanetFrom(imageUrl: parsedModel.url ?? "") {
            planetEntity = self.updateExistingTag(existingTag, parsedModel)
        } else {
            planetEntity = self.addNewTag(parsedModel)
        }
        if shouldSave == true {
            PersistentManager.shared.save()
        }
        return planetEntity
    }

    // Add new planet into DB
    private func addNewTag(_ parsedPlanet: GManSPlanet) -> Planet {
        let planet = Planet(context: PersistentManager.shared.context)
        planet.imageUrl = parsedPlanet.url
        return self.updateExistingTag(planet, parsedPlanet)
    }

    // Update existing planet into DB
    private func updateExistingTag(_ existingPlanet: Planet,
                                   _ parsedPlanet: GManSPlanet) -> Planet {
        existingPlanet.title = parsedPlanet.title
        existingPlanet.explanation = parsedPlanet.explanation
        existingPlanet.thumbUrl = parsedPlanet.thumbnail_url
        existingPlanet.mediaType = parsedPlanet.media_type
        existingPlanet.addedDate = parsedPlanet.date
        return existingPlanet
    }

    // Update existing planet with favourite value
    func updateFavStatus(isFav: Bool, url: String) {
        if let existingTag = self.getPlanetFrom(imageUrl: url) {
            existingTag.isFavourite = isFav
            PersistentManager.shared.save()
        }
    }
}
