//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Mariya on 05.12.2024.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.characters) { character in
                    CharacterRow(character: character)
                        .onAppear {
                            if character == viewModel.characters.last {
                                Task {
                                    await viewModel.loadMoreCharacters()
                                }
                            }
                        }
                }
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Characters")
            .onAppear {
                Task {
                    await viewModel.loadMoreCharacters()
                }
            }
        }
    }
}

struct CharacterRow: View {
    let character: CharacterEntity
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "person.crop.circle.badge.exclamationmark")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                Text("Species: \(character.species)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Gender: \(character.gender)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Status: \(character.status)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    CharacterListView()
}
