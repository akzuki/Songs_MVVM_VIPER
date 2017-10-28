//
//  ListSongRouter.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation
import UIKit

protocol ListSongWireframeProtocol: class {
    func showSongDetail(forSong song: SongProtocol, fromView view: ListSongViewProtocol)
}

class ListSongWireframe: ListSongWireframeProtocol {
    class func createListSongModule() -> UIViewController {
        let remoteSongService = RemoteSongService()
        let localSongService = LocalSongService()
        let listSongInteractor = ListSongInteractor(remoteSongSerivce: remoteSongService, localSongService: localSongService)
        let listSongPresenter = ListSongPresenter(interactor: listSongInteractor)
        listSongPresenter.wireframe = ListSongWireframe()
        let listSongViewController = ListSongViewController(presenter: listSongPresenter)
        
        return UINavigationController(rootViewController: listSongViewController)
    }
    
    func showSongDetail(forSong song: SongProtocol, fromView view: ListSongViewProtocol) {
        guard let vc = view as? UIViewController else {return}
        let songDetailViewController = SongDetailWireframe.createSongDetailModule(forSong: song)
        vc.navigationController?.pushViewController(songDetailViewController, animated: true)
    }
}
