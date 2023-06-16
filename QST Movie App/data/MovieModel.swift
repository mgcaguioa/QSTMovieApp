//
//  MovieModel.swift
//  QST Movie App
//
//  Created by Mark Caguioa on 6/15/23.
//

import Foundation

struct MovieModel: Codable, Identifiable, Hashable {
    let id: Int?
    let title: String?
    let poster: String?
    let description: String?
    let rating: Double?
    let duration: String?
    let genre: [String]?
    let releasedDate: String?
    let trailerLink: String?
    var isOnMyWatchList: Bool?
    
    func getGenres() -> String {
        return genre?.joined(separator: ", ") ?? "" // convert array to comma separated string
    }
    
    func getYear() -> String {
        return String(releasedDate?.suffix(4) ?? "") // gets year from releasedDate
    }
}
