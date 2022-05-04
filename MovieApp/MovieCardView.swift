//
//  ToggleButtonView.swift
//  MovieApp
//
//  Created by Five on 13.04.2022..
//

import Foundation
import UIKit
import MovieAppData

class MovieCardView : UIView {
    let shadowView = UIView()
    let cardView = UIView()
    let imageView = UIImageView()
    let textArea = UITextView()
    let title = UITextView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(movie : MovieModel) {
        self.init(frame: CGRect.zero)
        buildView(movie: movie)
        setLayout()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func buildView(movie: MovieModel) {
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
        
        let url = URL(string: movie.imageUrl)
        let data = try? Data(contentsOf: url!)
        imageView.image = UIImage(data: data!)
        
        title.text = movie.title + " (" + String(movie.year) + ")"
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.isScrollEnabled = false
        
        textArea.text = movie.description
        textArea.font = UIFont.systemFont(ofSize: 16)
        textArea.isEditable = false
        textArea.isScrollEnabled = false
        textArea.textAlignment = .left
        
        
        addSubview(shadowView)
        shadowView.addSubview(cardView)
        cardView.addSubview(imageView)
        cardView.addSubview(title)
        cardView.addSubview(textArea)
        
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
            make.height.equalTo(209)
        }
        
        title.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        textArea.snp.makeConstraints{ (make) in
            make.top.equalTo(title.snp.bottom)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
