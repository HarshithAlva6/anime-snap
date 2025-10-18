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
        NavigationView {
            ZStack {
                VStack {
                    if let error = viewModel.error {
                        VStack {
                            Text("Error Loading Recommendations:").font(.headline).foregroundColor(.red)
                            Text(error.localizedDescription).font(.subheadline).foregroundColor(.secondary)
                            Button("Retry") { viewModel.fetchRecommendations() }.padding(.top, 10)
                        }
                        .padding()
                    }
                    else if viewModel.recommendationItems.isEmpty {
                        Text("No user recommendations found.")
                            .foregroundColor(.secondary)
                            .padding()
                    }
                    else {
                        List(viewModel.recommendationItems) { item in
                            RecommendationRowView(item: item)
                                .padding(.vertical, 4)
                        }
                    }
                }
                .opacity(viewModel.isLoading ? 0 : 1)
                
                if viewModel.isLoading {
                    ProgressView("Fetching User Recommendations...")
                        .scaleEffect(1.2)
                        .padding(30)
                        .background(.ultraThinMaterial) // Gives the spinner a nice background
                        .cornerRadius(10)
                        .transition(.opacity)
                }
            }
            .navigationTitle("User Recommendations")
            .onAppear {
                viewModel.fetchRecommendations()
            }
            .animation(.easeInOut(duration: 0.2), value: viewModel.isLoading)
        }
    }
}

struct RecommendationRowView: View {
    
    let item: RecommendationItem
    @State private var isContentExpanded: Bool = false
    private let contentCharacterLimit: Int = 200
    private let contentLimit: Int = 3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            HStack {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.blue)
                Text(item.user.username)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.content)
                    .font(.body)
                    .italic()
                    .lineLimit(isContentExpanded ? nil : contentLimit)
                
                if item.content.count > contentCharacterLimit {
                    Button(isContentExpanded ? "Show Less" : "Read More...") {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isContentExpanded.toggle()
                        }
                    }
                    .font(.caption.bold())
                    .foregroundColor(.blue)
                }
            }
            .padding(.leading, 5)
            
            Text("Recommended Titles:")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 4)
            
            VStack(alignment: .leading, spacing: 6) {
                ForEach(item.entries) { entry in
                    HStack(alignment: .top, spacing: 10) {
                        
                        AsyncImage(url: URL(string: entry.image_url)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 50, height: 70)
                        .cornerRadius(4)
                        
                        Text(entry.title)
                            .font(.callout)
                            .fontWeight(.medium)
                            .lineLimit(2)
                    }
                }
            }
            .padding(.leading, 10)
        }
    }
}

#Preview {
    RecView()
}
