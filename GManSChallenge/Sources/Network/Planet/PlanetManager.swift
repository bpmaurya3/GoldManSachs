//
//  PlanetManager.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 01/09/22.
//

import Foundation

class PlanetManager {
    var planetTransaction: PlanetNetworkTransaction?

    private func getPlanetTransaction() -> PlanetNetworkTransaction? {
        if self.planetTransaction == nil {
            self.planetTransaction = PlanetNetworkTransaction(baseUrl: Constants.PlanetNetworkTransaction.baseURL)
        }
        return self.planetTransaction
    }


    func getPlanets(date: String?,
                    onSuccess: @escaping (_ statusCode: Int, _ planets: [Planet]) -> Void,
                    onFailure: @escaping (_ error: GManSError) -> Void) {
        guard let planetTransaction = self.getPlanetTransaction() else {
            print("transaction is not initialized")
            onFailure(GManSError())
            return
        }
        planetTransaction.getPlanet(date: date, onSuccess: { status, data, _ in
            PlanetParser().parsePlanetListResponse(data) { parsedModel in
                PersistentManager.shared.context.performAndWait {
                    var savedModels = [Planet]()
                    parsedModel.forEach { parsePlanet in
                        let planet = PlanetDao().addOrUpdate(parsedModel: parsePlanet, shouldSave: false)
                        savedModels.append(planet)
                    }
                    PersistentManager.shared.save()
                    onSuccess(status, savedModels)
                }
            }
        }, onFailure: { dataError, _ in
            onFailure(dataError)
        })
    }
}
