//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Mariya on 05.12.2024.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func getCharacters(page: Int) async throws -> [CharacterEntity]
    func getTotalPages() async throws -> Int
}

final class CharacterRepository: CharacterRepositoryProtocol {
    
    private var totalPages: Int = 0
    
    func getCharacters(page: Int) async throws -> [CharacterEntity] {
        let baseURL = "https://rickandmortyapi.com/api/character"
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }
        urlComponents.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(CharacterAPIResponse.self, from: data)
        
        totalPages = response.info.pages
        let characters = response.results.map { apiCharacter in
            CharacterEntity(
                id: apiCharacter.id,
                name: apiCharacter.name,
                status: apiCharacter.status,
                species: apiCharacter.species,
                gender: apiCharacter.gender,
                imageUrl: apiCharacter.image
            )
        }
        return characters
    }
    
    func getTotalPages() async throws -> Int {
        if totalPages > 0 {
            return totalPages
        } else {
            let _ = try await getCharacters(page: 1)
            return totalPages
        }
    }
}


struct CharacterAPIResponse: Decodable {
    let info: PaginationInfo
    let results: [APICharacter]
}

struct PaginationInfo: Decodable {
    let pages: Int
}

struct APICharacter: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}

