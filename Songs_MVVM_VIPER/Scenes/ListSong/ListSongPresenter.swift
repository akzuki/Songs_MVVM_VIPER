//
//  ListSongViewModel.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation

protocol ListSongPresenterProtocol: class {
    weak var view: ListSongViewProtocol? { get set }
    
    var songs: [SongProtocol] { get }
    
    func loadSongs()
    func refreshSongs()
    
    func showSongDetail(index: Int)
    func songForIndex(index: Int) -> SongProtocol
}

class ListSongPresenter: ListSongPresenterProtocol {
    //MARK: - View
    weak var view: ListSongViewProtocol?
    
    var songs: [SongProtocol] = []
    
    //MARK: - Interactor
    fileprivate let interactor: ListSongInteractorProtocol
    //MARK: - Wireframe
    var wireframe: ListSongWireframeProtocol?
    
    init(interactor: ListSongInteractorProtocol) {
        self.interactor = interactor
    }
    
    func loadSongs() {
        interactor.retrieveLocalSongs { [weak self] (result) in
            switch result {
            case .success(let songs):
                self?.songs = songs
                self?.view?.displaySongs(songs)
                self?.refreshSongs()
            case .failure(let error):
                self?.view?.onError(error)
            }
        }
    }
    
    func refreshSongs() {
        view?.showLoading()
        interactor.retrieveRemoteSongs { [weak self] (result) in
            self?.view?.hideLoading()
            switch result {
            case .success(let songs):
                self?.songs = songs
                self?.view?.displaySongs(songs)
            case .failure(let error):
                self?.view?.onError(error)
            }
        }
    }
    
    func showSongDetail(index: Int) {
        let song = songs[index]
        guard let view = view else {return}
        wireframe?.showSongDetail(forSong: song, fromView: view)
    }
    
    func songForIndex(index: Int) -> SongProtocol {
        return songs[index]
    }
}
