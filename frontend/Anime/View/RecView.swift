//
//  RecView.swift
//  Anime
//
//  Created by Harshith Harijeevan on 10/16/25.
//

import SwiftUI

struct RecView: View {
    @StateObject var viewModel = RecViewModel()
    
    var body: some View {
        List(viewModel.recommendationItems) { item in
            VStack(alignment: .leading, spacing: 8) {
                // Show username from nested user object
                Text("Recommended by: \(item.user.username)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(item.content)
                    .italic()
                
                ForEach(item.entries) { entry in
                    Text("- \(entry.title)")
                        .font(.headline)
                }
            }
            .padding(.vertical, 6)
        }
        .onAppear {
            viewModel.fetchRecommendations()
        }
        .navigationTitle("User Recommendations")
    }
}

#Preview {
    RecView()
}
