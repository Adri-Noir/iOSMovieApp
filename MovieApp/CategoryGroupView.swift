//
//  CategoryGroupView.swift
//  MovieApp
//
//  Created by Five on 15.04.2022..
//

import Foundation
import UIKit
import MovieAppData


protocol CollectionViewActions: AnyObject {
    func movieClicked(movie: MovieData)
    func movieLiked(movie: MovieData)
}



class CategoryGroupView : UIView {
    let title = UITextField()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var movieCollection = MovieCollectionView()
    var selectedButtonId = -1
    let buttonBorder : UIView = {
        let border = UIView()
        border.backgroundColor = .black
        return border
    }()

    var currentBoldButton = UIButton()
    weak var movieDelegate: MovieCollectionViewActions?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(group: MovieGroup) {
        self.init(frame: CGRect.zero)
        buildView(group: group)
        setLayout()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func buildView(group: MovieGroup) {
        movieCollection.movieDelegate = self
        
        addSubview(title)
        title.text = String(reflecting: group).components(separatedBy: ".").last?.titleCase()
        title.font = UIFont.boldSystemFont(ofSize: 24)
        title.isUserInteractionEnabled = false
        
        addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        addSubview(movieCollection)
    }
    
    
    func refreshFilters(filterList: [GenreModel]) {
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        
        var counter = 0
        for filter in filterList {
            let button = UIButton()
            button.setTitle(filter.name, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.tag = Int(filter.id)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            
            button.addTarget(self, action: #selector(toggleButtonAction(sender:)), for: .touchUpInside)
            
            if counter == 0 {
                currentBoldButton = button
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
                button.addSubview(buttonBorder)
                buttonBorder.snp.makeConstraints{ (make) in
                    make.leading.trailing.equalToSuperview()
                    make.top.equalTo(button.snp.bottom).offset(3)
                    make.height.equalTo(3)
                }
                selectedButtonId = filter.id
                
            }
            counter += 1
            stackView.addArrangedSubview(button)
        }
    }
    
    
    func fillCollectionViewWithData(movieData: [MovieData]) {
        movieCollection.movies = movieData
        movieCollection.filterMovies(filter: selectedButtonId)
    }
    
    
    func reloadData() {
        movieCollection.reloadData()
    }
    
    
    func setLayout() {
        title.snp.makeConstraints{ (make) in
            make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(10)
        }
        
        scrollView.snp.makeConstraints{ (make) in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        stackView.snp.makeConstraints{ (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        movieCollection.snp.makeConstraints{ (make) in
            make.top.equalTo(scrollView.snp.bottom).offset(10)
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(225)
            make.leading.equalToSuperview()
        }
    }
    
    @objc private func toggleButtonAction(sender: UIButton) {
        currentBoldButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonBorder.removeFromSuperview()
        
        
        sender.addSubview(buttonBorder)
        buttonBorder.snp.makeConstraints{ (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(sender.snp.bottom).offset(3)
            make.height.equalTo(3)
        }
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        currentBoldButton = sender
        selectedButtonId = sender.tag
        movieCollection.filterMovies(filter: sender.tag)
    }
    
}


extension String {
    func titleCase() -> String {
        return self
            .replacingOccurrences(of: "([A-Z])",
                                  with: " $1",
                                  options: .regularExpression,
                                  range: range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
}


extension CategoryGroupView: CollectionViewActions {
    func movieClicked(movie: MovieData) {
        movieDelegate?.userClickedMovie(movie: movie)
    }
    
    func movieLiked(movie: MovieData) {
        movieDelegate?.userClickedLike(movie: movie)
    }
}


