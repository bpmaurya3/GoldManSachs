//
//  PictureListViewModel.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import Foundation

final class PictureListViewModel {

    // Closures
    var notifyToReload: (() -> Void)?
    var openDetails: ((PlanetCellModel) -> Void)?
    var showHideLoadingIndicator: ((Bool) -> Void)?

    // Variables
    private let planetManager: PlanetManager
    private var datasource = [PlanetCellModel]()
    var lastSelectedSegmentIndex = 0
    var selectedDateString: String?

    // Initializer
    init(planetManager: PlanetManager) {
        self.planetManager = planetManager
        self.fetchPlanetFromServer(date: nil)
    }

    /// Setup datasource
    /// - Parameter planets: DB model
    private func setupDataSource(planets: [Planet]) {
        var cellModels = [PlanetCellModel]()
        planets.forEach { planet in
            cellModels.append(PlanetCellModel(from: planet))
        }
        self.datasource = cellModels
    }
}

extension PictureListViewModel {

    /// fetch the data from DB
    private func fetchPlanetFromDB() {
        var predicate: NSPredicate?
        if let date = self.selectedDateString, self.lastSelectedSegmentIndex == 0 {
            predicate = NSPredicate(format: "\(#keyPath(Planet.addedDate)) == %@", date)
        }

        var planets = PersistentManager.shared.fetch(Planet.self, predicate: predicate)

        if self.lastSelectedSegmentIndex == 1 {
            planets = planets.filter { $0.isFavourite == true }
        }
        self.setupDataSource(planets: planets)
        self.notifyToReload?()
    }


    /// Fetch planets from server
    /// - Parameter date: should be string which we pass to API as strat & end date
    func fetchPlanetFromServer(date: String?) {
        self.showHideLoadingIndicator?(true)
        self.selectedDateString = date
        self.planetManager.getPlanets(date: date){ [weak self] _, _ in
            self?.showHideLoadingIndicator?(false)
            self?.fetchPlanetFromDB()
        } onFailure: { [weak self] error in
            self?.showHideLoadingIndicator?(false)
            print("\(error.localizedDescription)")
        }
    }


    /// Refresh UI based on segment selection
    /// - Parameter index: should be a integer
    func getPlanetForSelectedSegment(index: Int) {
        self.lastSelectedSegmentIndex = index
        self.fetchPlanetFromDB()
    }
}

extension PictureListViewModel {

    /// Get datadource
    /// - Returns: Array of PlanetCellModel
    func getDataSource() -> [PlanetCellModel] {
        self.datasource
    }
}
