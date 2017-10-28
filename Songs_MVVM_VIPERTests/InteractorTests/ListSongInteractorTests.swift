//
//  ListSongInteractorTests.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import XCTest
@testable import Songs_MVVM_VIPER

class ListSongInteractorTests: XCTestCase {
    fileprivate var subject: ListSongInteractor!
    fileprivate var localSongServiceMock: LocalSongServiceProtocol!
    fileprivate var remoteSongServiceMock: RemoteSongServiceProtocol!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        subject = nil
        localSongServiceMock = nil
        remoteSongServiceMock = nil
    }
    
    
    /// Test case: When interactor retrieves local songs. Expect songs returned to be identical as ones in mock service.
    func test_retrieve_local_songs_successfully() {
        //given
        let localSongs: [SongProtocol] = [LocalSong(id: 1, name: "song_name_1", artist: "song_artist_1", url: "song_url_1", lyrics: "song_lyrics_1"),
                          LocalSong(id: 2, name: "song_name_2", artist: "song_artist_2", url: "song_url_2", lyrics: "song_lyrics_2")]
        let remoteSongs: [SongProtocol] = [RemoteSong(id: 3, name: "song_name_3", artist: "song_artist_3", url: "song_url_3", lyrics: "song_lyrics_3"),
                           RemoteSong(id: 4, name: "song_name_4", artist: "song_artist_4", url: "song_url_4", lyrics: "song_lyrics_4"),
                           RemoteSong(id: 5, name: "song_name_5", artist: "song_artist_5", url: "song_url_5", lyrics: "song_lyrics_5"),
                           RemoteSong(id: 6, name: "song_name_6", artist: "song_artist_6", url: "song_url_6", lyrics: "song_lyrics_6"),
                           ]
        localSongServiceMock = LocalSongServiceMock(result: [
            .success(localSongs)
            ])
        remoteSongServiceMock = RemoteSongServiceMock(result: [
            .success(remoteSongs)
            ])
        subject = ListSongInteractor(remoteSongSerivce: remoteSongServiceMock, localSongService: localSongServiceMock)
        
        //when
        var outputResult: [SongProtocol]?
        var outputError: AppError?
        subject.retrieveLocalSongs { (result) in
            switch result {
            case .success(let songs):
                outputResult = songs
            case .failure(let error):
                outputError = error
            }
        }
        
        //then
        XCTAssertEqual(outputResult?.count, localSongs.count)
        XCTAssertNil(outputError)
        Helper.equal(lhs: outputResult!, rhs: localSongs)
    }
    
    /// Test case: When interactor retrieves local songs. It fails. Expect EMPTY [SongProtocol]
    func test_retrieve_local_songs_failed() {
        //given
        let remoteSongs: [SongProtocol] = [RemoteSong(id: 3, name: "song_name_3", artist: "song_artist_3", url: "song_url_3", lyrics: "song_lyrics_3"),
                                           RemoteSong(id: 4, name: "song_name_4", artist: "song_artist_4", url: "song_url_4", lyrics: "song_lyrics_4"),
                                           RemoteSong(id: 5, name: "song_name_5", artist: "song_artist_5", url: "song_url_5", lyrics: "song_lyrics_5"),
                                           RemoteSong(id: 6, name: "song_name_6", artist: "song_artist_6", url: "song_url_6", lyrics: "song_lyrics_6"),
                                           ]
        localSongServiceMock = LocalSongServiceMock(result: [
            .failure(.cannotLoadSongs)
            ])
        remoteSongServiceMock = RemoteSongServiceMock(result: [
            .success(remoteSongs)
            ])
        subject = ListSongInteractor(remoteSongSerivce: remoteSongServiceMock, localSongService: localSongServiceMock)
        
        //when
        var outputResult: [SongProtocol]?
        var outputError: AppError?
        subject.retrieveLocalSongs { (result) in
            switch result {
            case .success(let songs):
                outputResult = songs
            case .failure(let error):
                outputError = error
            }
        }
        
        //then
        XCTAssertEqual(outputResult?.count, 0)
        XCTAssertNil(outputError)
    }
    
    /// Test case: When interactor retrieves remote songs. Expect songs returned to be identical as ones in mock service.
    func test_retrieve_remote_songs_successfully() {
        //given
        let localSongs: [SongProtocol] = [LocalSong(id: 1, name: "song_name_1", artist: "song_artist_1", url: "song_url_1", lyrics: "song_lyrics_1"),
                                          LocalSong(id: 2, name: "song_name_2", artist: "song_artist_2", url: "song_url_2", lyrics: "song_lyrics_2")]
        let remoteSongs: [SongProtocol] = [RemoteSong(id: 3, name: "song_name_3", artist: "song_artist_3", url: "song_url_3", lyrics: "song_lyrics_3"),
                                           RemoteSong(id: 4, name: "song_name_4", artist: "song_artist_4", url: "song_url_4", lyrics: "song_lyrics_4"),
                                           RemoteSong(id: 5, name: "song_name_5", artist: "song_artist_5", url: "song_url_5", lyrics: "song_lyrics_5"),
                                           RemoteSong(id: 6, name: "song_name_6", artist: "song_artist_6", url: "song_url_6", lyrics: "song_lyrics_6"),
                                           ]
        localSongServiceMock = LocalSongServiceMock(result: [
            .success(localSongs)
            ])
        remoteSongServiceMock = RemoteSongServiceMock(result: [
            .success(remoteSongs)
            ])
        subject = ListSongInteractor(remoteSongSerivce: remoteSongServiceMock, localSongService: localSongServiceMock)
        
        //when
        var outputResult: [SongProtocol]?
        var outputError: AppError?
        subject.retrieveRemoteSongs { (result) in
            switch result {
            case .success(let songs):
                outputResult = songs
            case .failure(let error):
                outputError = error
            }
        }
        
        //then
        XCTAssertEqual(outputResult?.count, remoteSongs.count)
        XCTAssertNil(outputError)
        Helper.equal(lhs: outputResult!, rhs: remoteSongs)
    }
    
    /// Test case: When interactor retrieves remote songs. It fails. Expect error to be .cannotLoadSong
    func test_retrieve_remote_songs_failed() {
        //given
        let localSongs: [SongProtocol] = [LocalSong(id: 1, name: "song_name_1", artist: "song_artist_1", url: "song_url_1", lyrics: "song_lyrics_1"),
                                          LocalSong(id: 2, name: "song_name_2", artist: "song_artist_2", url: "song_url_2", lyrics: "song_lyrics_2")]
        localSongServiceMock = LocalSongServiceMock(result: [
            .success(localSongs)
            ])
        remoteSongServiceMock = RemoteSongServiceMock(result: [
            .failure(.cannotLoadSongs)
            ])
        subject = ListSongInteractor(remoteSongSerivce: remoteSongServiceMock, localSongService: localSongServiceMock)
        
        //when
        var outputResult: [SongProtocol]?
        var outputError: AppError?
        subject.retrieveRemoteSongs { (result) in
            switch result {
            case .success(let songs):
                outputResult = songs
            case .failure(let error):
                outputError = error
            }
        }
        
        //then
        XCTAssertNil(outputResult)
        XCTAssertEqual(outputError, .cannotLoadSongs)
    }
}

final class LocalSongServiceMock: LocalSongServiceProtocol {
    fileprivate var result: [Result<[SongProtocol]>]
    
    var savedSongs: [LocalSong] = []
    
    init(result: [Result<[SongProtocol]>]) {
        self.result = result
    }
    
    func loadSongsFromLocal(completion: ((Result<[SongProtocol]>) -> Void)) {
        completion(result.removeFirst())
    }
    
    func saveSongs(songs: [SongProtocol]) {
        savedSongs = songs.map { LocalSong(id: $0.id, name: $0.name, artist: $0.artist, url: $0.url, lyrics: $0.lyrics) }
    }
}

final class RemoteSongServiceMock: RemoteSongServiceProtocol {
    fileprivate var result: [Result<[SongProtocol]>]
    
    init(result: [Result<[SongProtocol]>]) {
        self.result = result
    }
    
    func loadRemoteSongs(completion: @escaping ((Result<[SongProtocol]>) -> Void)) {
        completion(result.removeFirst())
    }
}
