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
        let configNormal = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium, scale: .default)
        button.setImage(UIImage(systemName: "heart", withConfiguration: configNormal)!.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.backgroundColor = UIColor(red: 0.04, green: 0.15, blue: 0.25, alpha: 0.6)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(userPressedLike), for: .touchUpInside)
        return button
    }()
    let likeButtonBold : UIButton = {
        let button = UIButton()
        let configSelected = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .default)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: configSelected)!.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(userPressedLike), for: .touchUpInside)
        return button
    }()
    
    var movieData : MovieData?
    
    weak var movieDelegate: MovieCellDelegate?
    
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
        likeButton.addSubview(likeButtonBold)
    }
    
    func setupLayouts() {
        movieImage.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(5)
            make.width.height.equalTo(40)
        }
        
        likeButtonBold.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(0)
        }
    }
    
    
    @objc func userPressedLike(sender: UIButton!) {
        if movieData != nil && movieData?.favorite != nil {
            if !self.movieData!.favorite {
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                    self.layoutBoldLikeButton(40)
                    
                    self.likeButton.layoutIfNeeded()
                    
                } completion: { _ in }

            } else {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                    self.layoutBoldLikeButton(6)
                    
                    
                    self.likeButton.layoutIfNeeded()
                } completion: { _ in
                    self.layoutBoldLikeButton(0)
                }
            }

            movieDelegate?.userClickedLike(movie: movieData!)
        }
    }
    
    func layoutBoldLikeButton(_ height: Int) {
        likeButtonBold.snp.updateConstraints { make in
            make.width.height.equalTo(height)
        }
    }
    
    
    func setup(movie : MovieData) {
        movieData = movie
        self.movieImage.image = UIImage(named: "whitebackground.jpeg")
        
        var poster = ""
        if movie.poster_path == nil {
            if movie.backdrop_path != nil {
                poster = movie.backdrop_path!
            }
        } else {
            poster = movie.poster_path!
        }

        let url = URL(string: "https://image.tmdb.org/t/p/w500"+poster)

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    self.movieImage.image = UIImage(data: data)
                }
            }
        }
        

        
        if movie.favorite {
            layoutBoldLikeButton(40)
        } else {
            layoutBoldLikeButton(0)
        }
    }
}

