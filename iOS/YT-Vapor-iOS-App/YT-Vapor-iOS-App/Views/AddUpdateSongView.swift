//
//  AddUpdateSongView.swift
//  YT-Vapor-iOS-App
//
//  Created by Juan Bazan Carrizo on 14/09/2022.
//

import SwiftUI

struct AddUpdateSongView: View {
    
    // MARK: - PROPERTIES
    @ObservedObject var viewModel: AddUpdateSongViewModel
    @Environment(\.presentationMode) var presentationModel
    
    // MARK: - BODY
    var body: some View {
        VStack {
            TextField("Song title", text: $viewModel.songTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button {
                viewModel.addUpdateAction {
                    presentationModel.wrappedValue.dismiss()
                }
            } label: {
                Text(viewModel.buttonTitle)
            }
        }
        
    }
}

// MARK: - PREVIEW
struct AddUpdateSongView_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateSongView(viewModel: AddUpdateSongViewModel())
    }
}
