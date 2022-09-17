//
//  CreateSongs.swift
//  
//
//  Created by Juan Francisco Bazan Carrizo on 03/09/2022.
//

import Fluent

struct CreateSongs: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("songs")
            .id()
            .field("title", .string, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("songs")
            .delete()
    }
}
