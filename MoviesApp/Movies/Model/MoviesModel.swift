//
//  MoviesModel.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 17/11/2023.
//

import Foundation

// MARK: - MoviesModel
struct MoviesModel: Codable {
    var code: Int?
    var status, copyright, attributionText, attributionHTML: String?
    var etag: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var offset, limit, total, count: Int?
    var results: [MovieResult]?
}

// MARK: - MovieResult
struct MovieResult: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var resourceURI: String?
    var urls: [URLElement]?
    var startYear, endYear: Int?
    var rating: String?
    var type: String?
    var thumbnail: Thumbnail?
}


enum Rating: String, Codable {
    case empty = ""
    case marvelPsr = "Marvel Psr"
    case ratedT = "Rated T"
    case ratingRatedT = "Rated T+"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    var path: String?
    var thumbnailExtension: Extension?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case jpg = "jpg"
}
// MARK: - URLElement
struct URLElement: Codable {
    var type: URLType?
    var url: String?
}

enum URLType: String, Codable {
    case detail = "detail"
}
