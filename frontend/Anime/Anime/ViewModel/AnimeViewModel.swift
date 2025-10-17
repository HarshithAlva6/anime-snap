//
//  AnimeViewModel.swift
//  Anime
//
//  Created by Harshith Harijeevan on 10/15/25.
//

import Foundation
import Combine

final class AnimeViewModel: ObservableObject {
    // 'final' means this class cannot be subclassed (a good practice).
    // 'ObservableObject' allows this class to notify SwiftUI views of changes.
    // MARK: - Published Properties (The State)
    @Published var topAnime: [Anime] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    // MARK: - Configuration
    private let apiEndpoint = URL(string: "http://127.0.0.1:8000/anime/top")!
    
    // MARK: - Networking Method
    func fetchTopAnime() {
        // Reset state before starting the fetch
        self.isLoading = true
        self.error = nil
        self.topAnime = []

        URLSession.shared.dataTask(with: self.apiEndpoint) { [weak self] data, response, error in
            
            // 3. All UI/Published property updates must be on the main thread
            DispatchQueue.main.async {
                guard let self = self else { return } // Safety check for weak self
                self.isLoading = false
                
                if let error = error {
                    self.error = error
                    return
                }

                guard let data = data else {
                    self.error = NSError(domain: "AppError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received from the backend."])
                    return
                }
                
                // 7. Decode the JSON data
                do {
                    let decodedData = try JSONDecoder().decode(TopAnimeResponse.self, from: data)
                    self.topAnime = decodedData.top_animes
                } catch {
                    // 8. Handle Decoding Error (JSON structure mismatch)
                    self.error = error
                    print("Decoding failed: \(error)")
                }
            }
        }.resume() // <--- Starts the data task
    }
}
