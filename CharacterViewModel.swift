//
//  ViewModel.swift
//  RickAndMorty
//
//  Created by Mariya on 05.12.2024.
//

import Foundation
import SwiftData

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [CharacterEntity] = []
    @Published var isLoading: Bool = false
    private var currentPage: Int = 1
    private var totalPages: Int = 0
    private let repository = CharacterRepository()
    
    func loadMoreCharacters() async {
        guard !isLoading else { return }
        guard currentPage <= totalPages || totalPages == 0 else { return }
        
        isLoading = true
        do {
            let newCharacters = try await repository.getCharacters(page: currentPage)
            characters.append(contentsOf: newCharacters)
            totalPages = try await repository.getTotalPages()
            currentPage += 1
        } catch {
            print("Ошибка загрузки: \(error)")
        }
        isLoading = false
    }
}
