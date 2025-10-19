//
//  WatchViewModel.swift
//  Anime
//
//  Created by Harshith Harijeevan on 10/18/25.
//

import Foundation
import Combine


class WatchViewModel: ObservableObject {
    @Published var episodes: [Episode] = []
    @Published var entries: [Entry] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    private let apiEndpoint = URL(string: "http://127.0.0.1:8000/episodes")!
    func fetchEpisodes() {
        guard !isLoading else { return }
        Task {
            self.isLoading = true
            self.error = nil
            defer { self.isLoading = false }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: self.apiEndpoint)
                
                guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
                    throw NSError(domain: "NetworkError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid server response."])
                }
                
                let decoded = try JSONDecoder().decode(Episodes.self, from: data)
                
                self.entries = decoded.entries
                self.episodes = decoded.episodes
            } catch {
                self.error = error
                print("Failed to fetch episodes: \(error)")
            }
        }
    }
}
