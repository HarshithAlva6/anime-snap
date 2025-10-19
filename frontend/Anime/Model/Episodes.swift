//
//  Episodes.swift
//  Anime
//
//  Created by Harshith Harijeevan on 10/18/25.
//

import Foundation

struct Episodes: Decodable {
    let entries: [Entry]
    let episodes: [Episode]
    
    private enum CodingKeys: String, CodingKey {
        case entry
        case entries
        case episodes
    }
    
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        
        if let many = try c.decodeIfPresent([Entry].self, forKey: .entries) {
            entries = many
        } else if let one = try c.decodeIfPresent(Entry.self, forKey: .entry) {
            entries = [one]
        } else {
            entries = []
        }
        
        episodes = try c.decode([Episode].self, forKey: .episodes)
    }
}

struct Entry: Identifiable, Decodable {
    let mal_id: Int
    let title: String
    let image_url: String
    let url: String
    
    var id: Int { mal_id }
    
    private enum CodingKeys: String, CodingKey {
        case mal_id
        case title
        case image_url
        case url
        case images
    }
    
    private struct Images: Decodable {
        struct Format: Decodable { let image_url: String }
        let jpg: Format?
        let webp: Format?
    }
    
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        mal_id = try c.decode(Int.self, forKey: .mal_id)
        title  = try c.decode(String.self, forKey: .title)
        url    = try c.decode(String.self, forKey: .url)
        
        if let images = try c.decodeIfPresent(Images.self, forKey: .images) {
            if let jpg = images.jpg?.image_url {
                image_url = jpg
            } else if let webp = images.webp?.image_url {
                image_url = webp
            } else {
                image_url = try c.decodeIfPresent(String.self, forKey: .image_url) ?? ""
            }
        } else {
            image_url = try c.decodeIfPresent(String.self, forKey: .image_url) ?? ""
        }
    }
}

struct Episode: Codable, Identifiable {
    let mal_id: Int
    let title: String
    let premium: Bool
    let url: String
    
    var id: Int { mal_id }
    
    private enum CodingKeys: String, CodingKey {
        case mal_id
        case title
        case premium
        case url
    }
}
