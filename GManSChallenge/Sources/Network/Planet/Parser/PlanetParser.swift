//
//  PlanetParser.swift
//  GManSChallenge
//
//  Created by Bhuvanendra Pratap Maurya on 02/09/22.
//

import Foundation

struct PlanetParser {
    func parsePlanetListResponse(_ data: Data, onCompletion: ([GManSPlanet]) -> Void) {
        let decoder = JSONDecoder()
        guard let listModel = try? decoder.decode([GManSPlanet].self, from: data) else {
            print("Planet parsing for parseLocationListResponse:: Fail")
            onCompletion([])
            return
        }
        onCompletion(listModel)
    }
}
