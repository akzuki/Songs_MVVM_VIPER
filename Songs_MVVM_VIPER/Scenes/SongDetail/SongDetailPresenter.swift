//
//  SongDetailPresenter.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation

protocol SongDetailPresenterProtocol: class {
    weak var view: SongDetailViewProtocol? { get set }
    
    func loadSong()
}

class SongDetailPresenter: SongDetailPresenterProtocol {
    //MARK: - View
    weak var view: SongDetailViewProtocol?
    //MARK: - Wireframe
    var wireframe: SongDetailWireframeProtocol?
    
    let song: SongProtocol
    
    init(song: SongProtocol) {
        self.song = song
    }
    
    func loadSong() {
        view?.displaySong(song: song)
    }
    
}
