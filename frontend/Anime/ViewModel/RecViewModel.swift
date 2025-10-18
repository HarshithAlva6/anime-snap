//
//  RecViewModel.swift
//  Anime
//
//  Created by Harshith Harijeevan on 10/16/25.
//

import Foundation
import Combine

@MainActor
final class RecViewModel: ObservableObject {
    
    // ⭐️ Published property now holds the complex array of recommendation items
    @Published var recommendationItems: [RecommendationItem] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    // ⭐️ Updated endpoint to match your FastAPI router
    private let apiEndpoint = URL(string: "http://127.0.0.1:8000/recommendations/anime")!
    
    func fetchRecommendations() {
        guard !isLoading else { return }
        Task {
            self.isLoading = true
            self.error = nil
            
            // 2. Guarantee cleanup
            defer { self.isLoading = false }
            
            do {
                // 3. Use the modern async URLSession API
                let (data, response) = try await URLSession.shared.data(from: self.apiEndpoint)
                
                // Optional: Check HTTP status code
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NSError(domain: "NetworkError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid server response."])
                }
                
                // 4. Decode data
                let container = try JSONDecoder().decode(RecommendationResponse.self, from: data)
                
                // 5. Update success state
                self.recommendationItems = container.recommendations
                self.error = nil
                
            } catch {
                // 6. Update failure state
                self.error = error
                print("Fetch or Decoding failed: \(error)")
            }
        }
    }
}
