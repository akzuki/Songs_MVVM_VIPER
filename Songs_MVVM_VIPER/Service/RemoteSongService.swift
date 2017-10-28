//
//  RemoteSongService.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation

protocol RemoteSongServiceProtocol {
    func loadRemoteSongs(completion: @escaping ((Result<[SongProtocol]>) -> Void))
}

class RemoteSongService: RemoteSongServiceProtocol {
    func loadRemoteSongs(completion: @escaping ((Result<[SongProtocol]>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let path = Bundle.main.path(forResource: "Songs", ofType: "json")!
            do {
                let songsData = try Data(contentsOf: URL(fileURLWithPath: path))
                let songs = try JSONDecoder().decode([RemoteSong].self, from: songsData)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    completion(.success(songs))
                })
            } catch {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    completion(.failure(AppError.cannotLoadSongs))
                })
            }
        }
    }
    
    
}
