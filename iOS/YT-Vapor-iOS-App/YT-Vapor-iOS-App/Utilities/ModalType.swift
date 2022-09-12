//
//  ModalType.swift
//  YT-Vapor-iOS-App
//
//  Created by Juan Francisco Bazan Carrizo on 08/09/2022.
//

import Foundation

enum ModalType: Identifiable {
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    
    case add
    case update(Song)
}
