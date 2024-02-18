//
//  ArtModel.swift
//  ArtApp
//
//  Created by Виталик Молоков on 14.02.2024.
//

import Foundation

struct Artist: Codable {
    let name: String
    let bio: String
    let image: String
    let works: [Work]
}

struct Work: Codable {
    let title: String
    let image: String
    let info: String
}

struct ArtistsData: Codable {
    let artists: [Artist]
}

enum SearchResult {
    case artist(Artist)
    case work(Artist, Work)
}

protocol SearchResultsDelegate: AnyObject {
    func didSelectSearchResult(_ result: SearchResult)
}
