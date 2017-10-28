//
//  ListSongInteractor.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation

protocol ListSongInteractorProtocol: class {
    func retrieveLocalSongs(completion: @escaping ((Result<[SongProtocol]>) -> Void))
    func retrieveRemoteSongs(completion: @escaping ((Result<[SongProtocol]>) -> Void))
}

class ListSongInteractor: ListSongInteractorProtocol {
    //MARK: - Service
    fileprivate let remoteSongSerivce: RemoteSongServiceProtocol
    fileprivate let localSongService: LocalSongServiceProtocol
    
    init(remoteSongSerivce: RemoteSongServiceProtocol,
         localSongService: LocalSongServiceProtocol) {
        self.remoteSongSerivce = remoteSongSerivce
        self.localSongService = localSongService
    }
    
    func retrieveLocalSongs(completion: @escaping ((Result<[SongProtocol]>) -> Void)) {
        localSongService.loadSongsFromLocal { (result) in
            switch result {
            case .success(let songs):
                completion(.success(songs))
            case .failure(_):
                completion(.success([]))
            }
        }
    }
    
    func retrieveRemoteSongs(completion: @escaping ((Result<[SongProtocol]>) -> Void)) {
        remoteSongSerivce.loadRemoteSongs { [weak self] (result) in
            switch result {
            case .success(let songs):
                completion(.success(songs))
                self?.localSongService.saveSongs(songs: songs)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
