//
//  LocalSongService.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation

protocol LocalSongServiceProtocol {
    func loadSongsFromLocal(completion: ((Result<[SongProtocol]>) -> Void))
    func saveSongs(songs: [SongProtocol])
}

class LocalSongService: LocalSongServiceProtocol {
    func loadSongsFromLocal(completion: ((Result<[SongProtocol]>) -> Void)) {
        let localSongs = [
            LocalSong(id: 1, name: "Despacito", artist: "Luis Fonsi & Daddy Yankee Featuring Justin Bieber", url: "https://i.ytimg.com/vi/kJQP7kiw5Fk/maxresdefault.jpg", lyrics: """
Comin' over in my direction
So thankful for that, it's such a blessin', yeah
Turn every situation into heaven, yeah
Oh-oh, you are
My sunrise on the darkest day
Got me feelin' some kind of way
Make me wanna savor every moment slowly, slowly
You fit me tailor-made, love how you put it on
Got the only key, know how to turn it on
The way you nibble on my ear, the only words I wanna hear
Baby, take it slow so we can last long
"""),
            LocalSong(id: 2, name: "Perfect", artist: "Ed Sheeran", url: "https://i.ytimg.com/vi/NDTBDYRW2cU/maxresdefault.jpg", lyrics: """
I found a love for me
Darling just dive right in
And follow my lead
Well I found a girl beautiful and sweet
I never knew you were the someone waiting for me
'Cause we were just kids when we fell in love
""")]
        completion(.success(localSongs))
    }
    
    func saveSongs(songs: [SongProtocol]) {
        let localSongs = songs.map { LocalSong(id: $0.id, name: $0.name, artist: $0.artist, url: $0.url, lyrics: $0.lyrics) }
        //Save localSongs to CoreData, Realm, SQLite
    }
}
