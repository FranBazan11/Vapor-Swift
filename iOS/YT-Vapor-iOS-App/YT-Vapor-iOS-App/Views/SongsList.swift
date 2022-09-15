//
//  SongsList.swift
//  YT-Vapor-iOS-App
//
//  Created by Juan Bazan Carrizo on 14/09/2022.
//

import SwiftUI

struct SongsList: View {
    // MARK: - PROPERTIES
    @StateObject var viewModel = SongListViewModel()
    @State var modal: ModalType? = nil
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.songs) { song in
                    Button {
                        modal = .update(song)
                    } label: {
                        Text(song.title)
                            .font(.title3)
                            .foregroundColor(Color(.label))
                    }
                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationTitle(Text("🎵Songs"))
            .toolbar(content: {
                Button {
                    modal = .add
                } label: {
                    Label("Add Song", systemImage: "plus.circle")
                }
            })
            .sheet(item: $modal, onDismiss: {
                Task {
                    do {
                        try await viewModel.fetchSongs()
                    } catch {
                        print("❌ \(error)")
                    }
                }
            }) { modal in
                switch modal {
                case .add:
                    AddUpdateSongView(viewModel: AddUpdateSongViewModel())
                case .update(let song):
                    AddUpdateSongView(viewModel: AddUpdateSongViewModel(currentSong: song))
                }
            }
            .onAppear {
                Task {
                    do {
                        try await viewModel.fetchSongs()
                    } catch {
                        print("❌ \(error)")
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct SongsList_Previews: PreviewProvider {
    static var previews: some View {
        SongsList()
    }
}
