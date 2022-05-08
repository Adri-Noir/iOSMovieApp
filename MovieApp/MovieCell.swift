//
//  MovieCell.swift
//  MovieApp
//
//  Created by Five on 11.04.2022..
//

import Foundation
import UIKit
import MovieAppData


class MovieCell: UICollectionViewCell {
    let movieImage = UIImageView()
    let likeButton : UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 21, weight: .medium, scale: .default)
        button.setImage(UIImage(systemName: "heart", withConfiguration: config)!.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(UIImage(systemName: "heart", withConfiguration: config)!.withTintColor(UIColor(red: 1.00, green: 0.12, blue: 0.21, alpha: 1.00), renderingMode: .alwaysOriginal), for: .selected)
        button.backgroundColor = UIColor(red: 0.04, green: 0.15, blue: 0.25, alpha: 0.6)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .white
        
        addSubview(movieImage)
        addSubview(likeButton)
    }
    
    func setupLayouts() {
        movieImage.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        
        }
    }
    
    func setup(movie : CategoryMovieModel) {
        var poster = ""
        if movie.posterPath == nil {
            if movie.backdropPath != nil {
                poster = movie.backdropPath!
            }
        } else {
            poster = movie.posterPath!
        }

        let url = URL(string: "https://image.tmdb.org/t/p/w500"+poster)

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    self.movieImage.image = UIImage(data: data)
                }
            }
        }
        
        likeButton.isSelected = false
    }
}

