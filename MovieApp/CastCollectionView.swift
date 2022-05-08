//
//  CastCollectionView.swift
//  MovieApp
//
//  Created by Five on 06.05.2022..
//

import Foundation
import SnapKit
import UIKit
import MovieAppData

class CastCollectionView: UIView {
    let cellIdentifier = "cellId"
    let collectionView : UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
    }()
    weak var appViewCollectionViewCommunicationDelegate : appViewCastCollectionCommunication?
    var castList : [[String]] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init() {
        self.init(frame: CGRect.zero)
        buildView()
        setLayout()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    
    func buildView() {
        addSubview(collectionView)
        backgroundColor = .white
        
        collectionView.isScrollEnabled = false
        collectionView.register(CastView.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
    }
    
    
    func setLayout() {
        
        collectionView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

    }

}


extension CastCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if castList.count > 6 {
            return 6
        }
        return castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath) as! CastView
        
        
        let cast = castList[indexPath.row]
        cell.setup(name: cast[0], job: cast[1])
        return cell
    }
}


extension CastCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    
}


extension CastCollectionView: NetworkServiceProtocol {
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
            
            guard let value = try? JSONDecoder().decode(TMDBCreditsModel.self, from: value) else {
                return
            }
            
            for crew in value.crew {
                self.castList.append([crew.name, crew.job])
            }
            
            DispatchQueue.global().sync {
                self.collectionView.reloadData()
            }
            
            self.appViewCollectionViewCommunicationDelegate?.castDataLoaded()
        }
    }
}
