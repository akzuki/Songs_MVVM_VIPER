//
//  ListSongPresenterTests.swift
//  MVVM-RxSwiftTestTests
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import XCTest
@testable import Songs_MVVM_VIPER

class ListSongPresenterTests: XCTestCase {
    fileprivate var subject: ListSongPresenter!
    fileprivate var listSongInteractorMock: ListSongInteractorProtocol!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        subject = nil
        listSongInteractorMock = nil
    }
    
    /// Test case: When user enters ListSongView -> Load song successfully. Expect results to be localSongs then remoteSongs
    func test_load_song_successfully() {
        //given
        let localSongs: [SongProtocol] = [LocalSong(id: 1, name: "song_name_1", artist: "song_artist_1", url: "song_url_1", lyrics: "song_lyrics_1"),
                                          LocalSong(id: 2, name: "song_name_2", artist: "song_artist_2", url: "song_url_2", lyrics: "song_lyrics_2")]
        let remoteSongs: [SongProtocol] = [RemoteSong(id: 3, name: "song_name_3", artist: "song_artist_3", url: "song_url_3", lyrics: "song_lyrics_3"),
                                           RemoteSong(id: 4, name: "song_name_4", artist: "song_artist_4", url: "song_url_4", lyrics: "song_lyrics_4"),
                                           RemoteSong(id: 5, name: "song_name_5", artist: "song_artist_5", url: "song_url_5", lyrics: "song_lyrics_5"),
                                           RemoteSong(id: 6, name: "song_name_6", artist: "song_artist_6", url: "song_url_6", lyrics: "song_lyrics_6"),
                                           ]
        listSongInteractorMock = ListSongInteractorMock(localSongsResult: [.success(localSongs)],
                                                        remoteSongResult: [.success(remoteSongs)])
        
        subject = ListSongPresenter(interactor: listSongInteractorMock)
        
        let mockView = MockListSongView()
        subject.view = mockView
        
        //when
        subject.loadSongs()
        
        //then
        XCTAssertEqual(mockView.loading, [true, false])
        XCTAssertEqual(mockView.errors, [])
        XCTAssertEqual(mockView.results.count, 2)
        Helper.equal(lhs: mockView.results[0], rhs: localSongs)
        Helper.equal(lhs: mockView.results[1], rhs: remoteSongs)
    }
    
    /// Test case: When user enters ListSongView -> Load song locally (success) -> Load song remotely (failed).
    func test_load_song_local_successfully_then_remote_failed() {
        //given
        let localSongs: [SongProtocol] = [LocalSong(id: 1, name: "song_name_1", artist: "song_artist_1", url: "song_url_1", lyrics: "song_lyrics_1"),
                                          LocalSong(id: 2, name: "song_name_2", artist: "song_artist_2", url: "song_url_2", lyrics: "song_lyrics_2")]
        listSongInteractorMock = ListSongInteractorMock(localSongsResult: [.success(localSongs)],
                                                        remoteSongResult: [.failure(.cannotLoadSongs)])
        
        subject = ListSongPresenter(interactor: listSongInteractorMock)
        
        let mockView = MockListSongView()
        subject.view = mockView
        
        //when
        subject.loadSongs()
        
        //then
        XCTAssertEqual(mockView.loading, [true, false])
        XCTAssertEqual(mockView.errors, [.cannotLoadSongs])
        XCTAssertEqual(mockView.results.count, 1)
        Helper.equal(lhs: mockView.results[0], rhs: localSongs)
    }
    
    /// Test case: When user enters ListSongView -> Load song locally (failed) -> Load song remotely (success).
    func test_load_song_local_failed_then_remote_successfully() {
        //given
        let remoteSongs: [SongProtocol] = [RemoteSong(id: 3, name: "song_name_3", artist: "song_artist_3", url: "song_url_3", lyrics: "song_lyrics_3"),
                                           RemoteSong(id: 4, name: "song_name_4", artist: "song_artist_4", url: "song_url_4", lyrics: "song_lyrics_4"),
                                           RemoteSong(id: 5, name: "song_name_5", artist: "song_artist_5", url: "song_url_5", lyrics: "song_lyrics_5"),
                                           RemoteSong(id: 6, name: "song_name_6", artist: "song_artist_6", url: "song_url_6", lyrics: "song_lyrics_6"),
                                           ]
        listSongInteractorMock = ListSongInteractorMock(localSongsResult: [.success([])],
                                                        remoteSongResult: [.success(remoteSongs)])
        
        subject = ListSongPresenter(interactor: listSongInteractorMock)
        
        let mockView = MockListSongView()
        subject.view = mockView
        
        //when
        subject.loadSongs()
        
        //then
        XCTAssertEqual(mockView.loading, [true, false])
        XCTAssertEqual(mockView.errors, [])
        XCTAssertEqual(mockView.results.count, 2)
        Helper.equal(lhs: mockView.results[0], rhs: [])
        Helper.equal(lhs: mockView.results[1], rhs: remoteSongs)
    }
    
    /// Test case: When user enters ListSongView -> Load song locally (failed) -> Load song remotely (failed).
    func test_load_song_local_failed_then_remote_failed() {
        //given
        listSongInteractorMock = ListSongInteractorMock(localSongsResult: [.success([])],
                                                        remoteSongResult: [.failure(.cannotLoadSongs)])
        
        subject = ListSongPresenter(interactor: listSongInteractorMock)
        
        let mockView = MockListSongView()
        subject.view = mockView
        
        //when
        subject.loadSongs()
        
        //then
        XCTAssertEqual(mockView.loading, [true, false])
        XCTAssertEqual(mockView.errors, [.cannotLoadSongs])
        XCTAssertEqual(mockView.results.count, 1)
        Helper.equal(lhs: mockView.results[0], rhs: [])
    }
    
    /// Test case: When user enters ListSongView -> Load song (success) -> Refresh song (success).
    func test_load_song_successfully_then_refresh_successfully() {
        //given
        let localSongs: [SongProtocol] = [LocalSong(id: 1, name: "song_name_1", artist: "song_artist_1", url: "song_url_1", lyrics: "song_lyrics_1"),
                                          LocalSong(id: 2, name: "song_name_2", artist: "song_artist_2", url: "song_url_2", lyrics: "song_lyrics_2")]
        let remoteSongs: [SongProtocol] = [RemoteSong(id: 3, name: "song_name_3", artist: "song_artist_3", url: "song_url_3", lyrics: "song_lyrics_3"),
                                           RemoteSong(id: 4, name: "song_name_4", artist: "song_artist_4", url: "song_url_4", lyrics: "song_lyrics_4"),
                                           RemoteSong(id: 5, name: "song_name_5", artist: "song_artist_5", url: "song_url_5", lyrics: "song_lyrics_5"),
                                           RemoteSong(id: 6, name: "song_name_6", artist: "song_artist_6", url: "song_url_6", lyrics: "song_lyrics_6"),
                                           ]
        let nextRemoteSongs: [SongProtocol] = [RemoteSong(id: 3, name: "song_name_7", artist: "song_artist_7", url: "song_url_7", lyrics: "song_lyrics_7"),
                                               RemoteSong(id: 4, name: "song_name_8", artist: "song_artist_8", url: "song_url_8", lyrics: "song_lyrics_8")]
        
        listSongInteractorMock = ListSongInteractorMock(localSongsResult: [.success(localSongs)],
                                                        remoteSongResult: [.success(remoteSongs), .success(nextRemoteSongs)])
        
        subject = ListSongPresenter(interactor: listSongInteractorMock)
        
        let mockView = MockListSongView()
        subject.view = mockView
        
        //when
        subject.loadSongs()
        subject.refreshSongs()
        
        //then
        XCTAssertEqual(mockView.loading, [true, false, true, false])
        XCTAssertEqual(mockView.errors, [])
        XCTAssertEqual(mockView.results.count, 3)
        Helper.equal(lhs: mockView.results[0], rhs: localSongs)
        Helper.equal(lhs: mockView.results[1], rhs: remoteSongs)
        Helper.equal(lhs: mockView.results[2], rhs: nextRemoteSongs)
    }
    
    /// Test case: When user enters ListSongView -> Load song (failed) -> Refresh song (success).
    func test_load_song_failed_then_refresh_successfully() {
        //given
        let localSongs: [SongProtocol] = [LocalSong(id: 1, name: "song_name_1", artist: "song_artist_1", url: "song_url_1", lyrics: "song_lyrics_1"),
                                          LocalSong(id: 2, name: "song_name_2", artist: "song_artist_2", url: "song_url_2", lyrics: "song_lyrics_2")]
        let nextRemoteSongs: [SongProtocol] = [RemoteSong(id: 3, name: "song_name_7", artist: "song_artist_7", url: "song_url_7", lyrics: "song_lyrics_7"),
                                               RemoteSong(id: 4, name: "song_name_8", artist: "song_artist_8", url: "song_url_8", lyrics: "song_lyrics_8")]
        
        listSongInteractorMock = ListSongInteractorMock(localSongsResult: [.success(localSongs)],
                                                        remoteSongResult: [.failure(.cannotLoadSongs), .success(nextRemoteSongs)])
        
        subject = ListSongPresenter(interactor: listSongInteractorMock)
        
        let mockView = MockListSongView()
        subject.view = mockView
        
        //when
        subject.loadSongs()
        subject.refreshSongs()
        
        //then
        XCTAssertEqual(mockView.loading, [true, false, true, false])
        XCTAssertEqual(mockView.errors, [.cannotLoadSongs])
        XCTAssertEqual(mockView.results.count, 2)
        Helper.equal(lhs: mockView.results[0], rhs: localSongs)
        Helper.equal(lhs: mockView.results[1], rhs: nextRemoteSongs)
    }
}

final class ListSongInteractorMock: ListSongInteractorProtocol {
    var localSongsResult: [Result<[SongProtocol]>]
    var remoteSongResult: [Result<[SongProtocol]>]
    
    init(localSongsResult: [Result<[SongProtocol]>],
         remoteSongResult: [Result<[SongProtocol]>]) {
        self.localSongsResult = localSongsResult
        self.remoteSongResult = remoteSongResult
    }
    
    func retrieveLocalSongs(completion: @escaping ((Result<[SongProtocol]>) -> Void)) {
        completion(localSongsResult.removeFirst())
    }
    
    func retrieveRemoteSongs(completion: @escaping ((Result<[SongProtocol]>) -> Void)) {
        completion(remoteSongResult.removeFirst())
    }
}

final class MockListSongView: ListSongViewProtocol {
    var results: [[SongProtocol]] = []
    var loading: [Bool] = []
    var errors: [AppError] = []
    
    func displaySongs(_ songs: [SongProtocol]) {
        results.append(songs)
    }
    
    func showLoading() {
        loading.append(true)
    }
    
    func hideLoading() {
        loading.append(false)
    }
    
    func onError(_ error: AppError) {
        errors.append(error)
    }
}


