//
//  Planet+CoreDataProperties.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 03/09/22.
//
//

import CoreData


extension Planet {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Planet> {
        return NSFetchRequest<Planet>(entityName: "Planet")
    }
    @NSManaged var title: String?
    @NSManaged var explanation: String?
    @NSManaged var isFavourite: Bool
    @NSManaged var thumbUrl: String?
    @NSManaged var imageUrl: String?
    @NSManaged var mediaType: String?
    @NSManaged var addedDate: String?
}
