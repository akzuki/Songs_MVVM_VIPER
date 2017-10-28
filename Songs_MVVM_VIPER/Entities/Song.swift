//
//  Song.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation

//MARK: - SongProtocol
protocol SongProtocol {
    var id: Int { get }
    var name: String { get }
    var artist: String { get }
    var url: String { get }
    var lyrics: String { get }
}

func ==(lhs: SongProtocol, rhs: SongProtocol) -> Bool {
    return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.artist == rhs.artist &&
        lhs.url == rhs.url &&
        lhs.lyrics == rhs.lyrics
}

/// Song returned from server
struct RemoteSong: SongProtocol, Decodable {
    var id: Int
    var name: String
    var artist: String
    var url: String
    var lyrics: String
}

/// Song returned from local storage e.g. CoreData, Realm, SQLite
struct LocalSong: SongProtocol {
    var id: Int
    var name: String
    var artist: String
    var url: String
    var lyrics: String
}

