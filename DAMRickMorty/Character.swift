//
//  Character.swift
//  DAMRickMorty
//
//  Created by José María Jiménez on 10/3/24.
//

import Foundation

struct Character: Decodable {
    let image: String
    let name: String
    let species: String
    let status: String
}
