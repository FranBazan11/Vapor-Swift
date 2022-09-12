//
//  SongController.swift
//  
//
//  Created by Juan Francisco Bazan Carrizo on 03/09/2022.
//

import Fluent
import Vapor

struct SongController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let songs = routes.grouped("songs")
        songs.get(use: index)
        songs.post(use: create)
        songs.put(use: update)
        songs.group(":songID") { song in
            song.delete(use: delete)
        }
    }
    
    // GET Request  /songs route
    func index(req: Request) throws -> EventLoopFuture<[Song]> {
        return Song.query(on: req.db).all()
    }
    
    // POST Request  /songs route
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let song = try req.content.decode(Song.self)
        return song.save(on: req.db).transform(to: .ok)
    }
    
    // PUT Request  /songs route
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let song = try req.content.decode(Song.self)
        
        return Song.find(song.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { songWrapped in 
                songWrapped.title = song.title
                return songWrapped.update(on: req.db).transform(to: .ok)
            }
    }
    
    // DELETE Request  /songs/id route
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Song.find(req.parameters.get("songID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { songWrapped in
                songWrapped.delete(on: req.db)
            }
            .transform(to: .ok)
    }
}
