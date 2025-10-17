//
//  RecViewModel.swift
//  Anime
//
//  Created by Harshith Harijeevan on 10/16/25.
//

import Foundation
import Combine

final class RecViewModel: ObservableObject {
    
    // ⭐️ Published property now holds the complex array of recommendation items
    @Published var recommendationItems: [RecommendationItem] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    // ⭐️ Updated endpoint to match your FastAPI router
    private let apiEndpoint = URL(string: "http://127.0.0.1:8000/recommendations/anime")!
    
    func fetchRecommendations() {
        self.isLoading = true
        self.error = nil
        self.recommendationItems = [] // Reset the list
        
        // This is a simple GET request
        URLSession.shared.dataTask(with: self.apiEndpoint) { [weak self] data, response, error in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                if let error = error {
                    self.error = error
                    return
                }

                guard let data = data else {
                    self.error = NSError(domain: "AppError", code: 2, userInfo: [NSLocalizedDescriptionKey: "No data received for recommendations."])
                    return
                }
                
                // ⭐️ Decode into the top-level container: RecommendationResponse
                do {
                    let container = try JSONDecoder().decode(RecommendationResponse.self, from: data)
                    
                    // Assign the nested array to the published property
                    self.recommendationItems = container.recommendations
                    
                } catch {
                    self.error = error
                    print("Recommendation Decoding failed: \(error)")
                }
            }
        }.resume()
    }
}
