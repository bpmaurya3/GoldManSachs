//
//  PictureDetailsViewModel.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 02/09/22.
//

import Foundation

final class PictureDetailsViewModel {
    private var datasource = [PlanetCellModel]()

    init(detailModel: PlanetCellModel) {
        self.datasource.append(detailModel)
    }
}

extension PictureDetailsViewModel {
    func getDataSource() -> [PlanetCellModel] {
        self.datasource
    }
}

extension PictureDetailsViewModel {
    func saveFavPlanetIntoDB(url: String, isFav: Bool) -> PlanetCellModel? {
        if let index = self.datasource.firstIndex(where: { $0.imageUrl == url }) {
            var item = self.datasource[index]
            item.isFavourite = isFav
            self.datasource[index] = item
            PlanetDao().updateFavStatus(isFav: isFav, url: url)
            return item
        }
        return nil
    }
}
