//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Five on 04.05.2022..
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController {
    let paperLikeView = UIView()
    
    override func viewDidLoad() {
        view.addSubview(paperLikeView)
        
        paperLikeView.backgroundColor = UIColor(red: 0.91, green: 0.93, blue: 0.96, alpha: 1.00)
        
        paperLikeView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        let navBar = UINavigationBarAppearance()
        navBar.backgroundColor = UIColor(red: 0.04, green: 0.15, blue: 0.25, alpha: 1.00)
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBar
        
        let titleView = UIView()
        let imageView = UIImageView(image: UIImage(named: "1a40d6f4d2d74d6370baae3e2adcfe1d"))
        imageView.contentMode = .scaleAspectFit
        titleView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        
        navigationItem.titleView = titleView
    }
}
