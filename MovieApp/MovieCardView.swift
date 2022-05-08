//
//  ToggleButtonView.swift
//  MovieApp
//
//  Created by Five on 13.04.2022..
//

import Foundation
import UIKit
import MovieAppData

class MovieCardView : UICollectionViewCell {
    let shadowView = UIView()
    let cardView = UIView()
    let imageView = UIImageView()
    let textArea = UITextView()
    let title = UITextView()
    let stackView = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildView()
        setLayout()
    }


    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func buildView() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 10

        shadowView.layer.cornerRadius = 10
        shadowView.backgroundColor = UIColor.clear
        shadowView.layer.shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.10).cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.masksToBounds = true
        
        
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.isScrollEnabled = false
        title.isSelectable = false
        
        textArea.font = UIFont.systemFont(ofSize: 16)
        textArea.isEditable = false
        textArea.isScrollEnabled = false
        textArea.textAlignment = .left
        textArea.isSelectable = false
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        let emptySpaceView = UIView()
        
        
        addSubview(shadowView)
        shadowView.addSubview(cardView)
        cardView.addSubview(imageView)
        cardView.addSubview(stackView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(textArea)
        stackView.addArrangedSubview(emptySpaceView)
        
    }
    
    func setLayout() {
        shadowView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
        
        cardView.snp.makeConstraints{ (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints{ (make) in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(140)
        }
        
        stackView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    
    func setup(movie: CategoryMovieModel) {
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
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
        
        
        if (movie.releaseDate != "") {
            title.text = movie.title + " (" + String(movie.releaseDate.split(separator: "-")[0]) + ")"
        } else {
            title.text = "Error: no title"
        }
        
        if (movie.overview != "") {
            textArea.text = movie.overview
        } else {
            textArea.text = "Error: no overview"
        }
        
    }
}
