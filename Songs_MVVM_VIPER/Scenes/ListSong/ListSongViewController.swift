//
//  ListSongViewController.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import UIKit

protocol ListSongViewProtocol: class {
    func displaySongs(_ songs: [SongProtocol])
    func showLoading()
    func hideLoading()
    func onError(_ error: AppError)
}

class ListSongViewController: BaseViewController {
    //MARK: - Subviews
    fileprivate lazy var songTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 200
        
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.reuseIdentifier)
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    fileprivate lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(ListSongViewController.handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - Presenter
    fileprivate let presenter: ListSongPresenterProtocol
    
    //MARK: - Init
    init(presenter: ListSongPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        presenter.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Songs"
        view.backgroundColor = UIColor.white
        
        view.addSubview(songTableView)
        setupConstraints()
        
        presenter.loadSongs()
    }
    
    fileprivate func setupConstraints() {
        [songTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         songTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
         songTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
         songTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter.refreshSongs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - ListSongViewProtocol
extension ListSongViewController: ListSongViewProtocol {
    func displaySongs(_ songs: [SongProtocol]) {
        songTableView.reloadData()
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        refreshControl.endRefreshing()
    }
    
    func onError(_ error: AppError) {
        
    }
}

//MARK: - UITableViewDataSource
extension ListSongViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SongTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let song = presenter.songForIndex(index: indexPath.row)
        cell.configure(song: song)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ListSongViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showSongDetail(index: indexPath.row)
    }
}


