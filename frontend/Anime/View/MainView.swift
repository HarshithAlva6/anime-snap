//
//  MainView.swift
//  Anime
//
//  Created by Harshith Harijeevan on 10/15/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Welcome to MyAnimeList")
                    .font(.title)
                NavigationLink(destination: AnimeView()){
                    Text("Show Top Anime")
                        .font(.headline)
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                NavigationLink(destination: RecView()) {
                    Text("Show Anime recommendations")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
            .navigationTitle("Main Menu")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MainView()
}
