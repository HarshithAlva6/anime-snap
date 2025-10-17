//
//  ContentView.swift
//  Anime
//
//  Created by Harshith Harijeevan on 10/15/25.
//

import SwiftUI

struct AnimeView: View {
    @StateObject var viewModel = AnimeViewModel()
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Top 10 Anime!")
                }
                else if let error = viewModel.error {
                    VStack {
                        Text("Error \(error.localizedDescription)")
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry Fetch") {
                            viewModel.fetchTopAnime()
                        }
                    }
                }
                else if viewModel.topAnime.isEmpty {
                    Text("No anime titles found")
                        .foregroundColor(.secondary)
                        .padding()
                }
                else {
                    List(viewModel.topAnime) {anime in
                        VStack(alignment: .leading) {
                            Text(anime.title)
                                .font(.headline)
                            Text("Score: \(anime.score, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Top Anime List")
        }
        .onAppear() {
            viewModel.fetchTopAnime()
        }
    }
}

#Preview {
    AnimeView()
}
