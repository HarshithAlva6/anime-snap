//
//  TranslateView.swift
//  Anime
//
//  Created by Harshith Harijeevan on 10/16/25.
//

import SwiftUI

struct WatchView: View {
    @StateObject private var viewModel = WatchViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Error state
                    if let error = viewModel.error {
                        VStack(spacing: 8) {
                            Text("Failed to load episodes")
                                .font(.headline)
                                .foregroundColor(.red)
                            Text(error.localizedDescription)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                            Button("Retry") {
                                viewModel.fetchEpisodes()
                            }
                            .padding(.top, 8)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    // Content
                    else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                if viewModel.entries.isEmpty {
                                    Text("No entries")
                                        .foregroundColor(.secondary)
                                } else {
                                    ForEach(viewModel.entries) { entry in
                                        EntryCardView(entry: entry)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        if viewModel.episodes.isEmpty && !viewModel.isLoading {
                            Text("No episodes found.")
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else {
                            List(viewModel.episodes) { episode in
                                EpisodeRowView(episode: episode)
                            }
                            .listStyle(.plain)
                        }
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView("Loading Episodes...")
                        .padding(24)
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                }
            }
            .navigationTitle("Watch")
            .onAppear {
                viewModel.fetchEpisodes()
            }
            .animation(.easeInOut(duration: 0.2), value: viewModel.isLoading)
        }
    }
}

private struct EntryCardView: View {
    let entry: Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: entry.image_url)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 120, height: 160)
            .clipped()
            .cornerRadius(8)
            
            Text(entry.title)
                .font(.caption)
                .lineLimit(2)
                .frame(width: 120, alignment: .leading)
        }
        .frame(width: 120)
        .onTapGesture {
            if let url = URL(string: entry.url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

private struct EpisodeRowView: View {
    let episode: Episode
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(episode.title)
                    .font(.body)
                    .fontWeight(.medium)
                
                Text("ID: \(episode.mal_id)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if episode.premium {
                Text("Premium")
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.orange.opacity(0.15))
                    .foregroundColor(.orange)
                    .cornerRadius(6)
            }
            if let url = URL(string: episode.url) {
                Link(destination: url) {
                    Image(systemName: "arrow.up.right.square")
                        .imageScale(.medium)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    WatchView()
}
