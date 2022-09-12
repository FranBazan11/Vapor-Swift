//
//  Song.swift
//  YT-Vapor-iOS-App
//
//  Created by Juan Francisco Bazan Carrizo on 04/09/2022.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: UUID?
    let title: String
}
