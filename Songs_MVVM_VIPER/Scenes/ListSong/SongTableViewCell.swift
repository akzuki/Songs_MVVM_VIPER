//
//  SongTableViewCell.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    //MARK: - Subviews
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Avenir-Book", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let darkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundImageView.addSubview(darkView)
        
        addSubview(backgroundImageView)
        addSubview(songNameLabel)
        addSubview(artistNameLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupConstraints() {
        [darkView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
        darkView.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor),
        darkView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
        darkView.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor),
        
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
        backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor),
        backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor),
        
        songNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
        songNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
        
        artistNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 6),
        artistNameLabel.leftAnchor.constraint(equalTo: songNameLabel.leftAnchor)
        ].forEach { $0.isActive = true}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(song: SongProtocol) {
        songNameLabel.text = song.name
        artistNameLabel.text = song.artist
        backgroundImageView.setImage(url: URL(string: song.url))
    }
}
