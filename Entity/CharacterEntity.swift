//
//  Character.swift
//  RickAndMorty
//
//  Created by Mariya on 05.12.2024.
//

import Foundation
import SwiftData

@Model
final class CharacterEntity: Equatable, Identifiable, Hashable {
    @Attribute(.unique) var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var imageUrl: String
    
    init(id: Int, name: String, status: String, species: String, gender: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.imageUrl = imageUrl
    }
}

