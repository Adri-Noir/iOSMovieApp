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
    func movieClicked(movie: CategoryMovieModel)
}



class CategoryGroupView : UIView {
    let title = UITextField()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var movieCollection = MovieCollectionView(group: .popular)
    let selectedButton = 0
    let buttonBorder : UIView = {
        let border = UIView()
        border.backgroundColor = .black
        return border
    }()
    let apiKey = "<api-key>"
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
        movieCollection = MovieCollectionView(group: group)
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
        
        
        switch(group) {
        case .trending:
            createFilters(filterList: [FilterInfo(name: "Day", id: -1), FilterInfo(name: "Week", id: -2)])
        default:
            getDataFromURL(requestUrl: "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key="+apiKey)
        }
        
        addSubview(movieCollection)
    }
    
    
    struct FilterInfo {
        let name : String
        let id : Int
    }
    
    
    func createFilters(filterList: [FilterInfo]) {
        var counter = 0
        for row in filterList {
            let button = UIButton()
            button.setTitle(row.name, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.tag = Int(row.id)
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
                movieCollection.filterMovies(filter: row.id)
                
            }
            counter += 1
            stackView.addArrangedSubview(button)
        }
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
    func movieClicked(movie: CategoryMovieModel) {
        movieDelegate?.userClickedMovie(movie: movie)
    }
}


extension CategoryGroupView : NetworkServiceProtocol {
    func getDataFromURL(requestUrl: String) {
        guard let url = URL(string: requestUrl) else { return  }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let networkService = NetworkService()
        networkService.executeUrlRequest(request) { dataValue, error in
            if error != nil {
                return
            }
            guard let value = dataValue else {
                return
            }
            
            
            guard let value = try? JSONDecoder().decode(TMDBGenresModel.self, from: value) else {
                return
            }
            
            var filterList : [FilterInfo] = []
            for row in value.genres {
                filterList.append(FilterInfo(name: row.name, id: row.id))
            }
            
            self.createFilters(filterList: filterList)
            
        }
    }
}
