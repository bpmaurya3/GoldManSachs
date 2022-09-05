//
//  PersistentManager.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 03/09/22.
//

import CoreData

final class PersistentManager {

    private init() {}

    static let shared = PersistentManager()

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GManSChallenge")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext

    // MARK: - Core Data Saving support

    func save() {
        if context.hasChanges {
            do {
                try context.save()
                print("Saved Successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            if let predicate = predicate {
                fetchRequest.predicate = predicate
            }
            let dateSort = NSSortDescriptor(key: #keyPath(Planet.addedDate), ascending: false)
            fetchRequest.sortDescriptors = [dateSort]
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print(error)
            return [T]()
        }
    }
}
