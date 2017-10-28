//
//  SongDetailWireframe.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation
import UIKit

protocol SongDetailWireframeProtocol {}

class SongDetailWireframe: SongDetailWireframeProtocol {
    class func createSongDetailModule(forSong song: SongProtocol) -> UIViewController {
        let songDetailPresenter = SongDetailPresenter(song: song)
        songDetailPresenter.wireframe = SongDetailWireframe()
        let songDetailViewController = SongDetailViewController(presenter: songDetailPresenter)
        return songDetailViewController
    }
}
