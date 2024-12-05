//
//  Untitled.swift
//  RickAndMorty
//
//  Created by Mariya on 05.12.2024.
//
import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack(spacing: 20) {
            //Spacer()
            Text("Rick and Morty's")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 180)
            Image("SplashImage")
                .scaledToFill()
                .frame(width: 200, height: 300)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Text("Characters")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 180)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SplashScreen()
}
