//
//  Respond.swift
//  RickAndMorty
//
//  Created by Mariya on 05.12.2024.
//

import Foundation

struct CharacterAPIResponse: Decodable {
    let info: PaginationInfo
    let results: [APICharacter]
}

struct APICharacter: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}

