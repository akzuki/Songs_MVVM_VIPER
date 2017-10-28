//
//  SongDetailViewController.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import UIKit

protocol SongDetailViewProtocol: class {
    func displaySong(song: SongProtocol)
}

class SongDetailViewController: BaseViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var lyricsLabel: UILabel!
    
    //MARK: - Presenter
    fileprivate let presenter: SongDetailPresenterProtocol
    
    //MARK: - Init
    init(presenter: SongDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "SongDetailViewController", bundle: nil)
        
        presenter.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        
        presenter.loadSong()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - SongDetailViewProtocol
extension SongDetailViewController: SongDetailViewProtocol {
    func displaySong(song: SongProtocol) {
        songNameLabel.text = song.name
        artistLabel.text = song.artist
        lyricsLabel.text = song.lyrics
    }
}
