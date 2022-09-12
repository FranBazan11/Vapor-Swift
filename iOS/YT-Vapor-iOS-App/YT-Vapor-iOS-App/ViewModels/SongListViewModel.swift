//
//  SongListViewModel.swift
//  YT-Vapor-iOS-App
//
//  Created by Juan Francisco Bazan Carrizo on 04/09/2022.
//

import Foundation

class SongListViewModel: ObservableObject {
    @Published var songs = [Song]()
    
    func fetchSongs() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let songsResponse: [Song] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.songs = songsResponse
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { i in
            guard let songID = songs[i].id else { return }
            
            let urlString = Constants.baseURL + Endpoints.songs + "/\(songID)"
            guard let url = URL(string: urlString) else { return }
            
            
            Task {
                do {
                    try await HttpClient.shared.delete(url: url)
                } catch {
                    print("❌ \(error)")
                }
            }
        }
        
        songs.remove(atOffsets: offsets)
    }
}
