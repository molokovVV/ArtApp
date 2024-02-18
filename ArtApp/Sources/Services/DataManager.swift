//
//  ArtDataModel.swift
//  ArtApp
//
//  Created by Виталик Молоков on 14.02.2024.
//

// DataManager.swift

import Foundation

class ArtistsDataLoader {
    static func loadJson(filename fileName: String) -> [Artist]? {
        if let url = Bundle.main.url(forResource: "artists", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ArtistsData.self, from: data)
                return jsonData.artists
            } catch {
                print("Error loading JSON data: \(error)")
            }
        }
        return nil
    }
}



