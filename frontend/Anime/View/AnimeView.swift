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
                    List(viewModel.topAnime) { anime in
                        HStack(alignment: .top, spacing: 12) {

                            AsyncImage(url: URL(string: anime.image_url)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Color.gray.opacity(0.3) // A simple gray box placeholder
                            }
                            .frame(width: 60, height: 80)
                            .cornerRadius(4)
                            .shadow(radius: 2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(anime.title)
                                    .font(.headline)
                                Text("Score: \(anime.score, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
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
