//
//  Episode.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 10/3/24.
//

import Foundation

struct Episode: Decodable {
    let name: String
    let airDate: String
    let episode: String

    enum CodingKeys: String, CodingKey {
        case name
        case airDate = "air_date"
        case episode
    }
}
