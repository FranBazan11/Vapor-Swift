//
//  Song.swift
//  YT-Vapor-iOS-App
//
//  Created by Juan Bazan Carrizo on 14/09/2022.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: UUID?
    let title: String
}
