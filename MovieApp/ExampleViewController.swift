//
//  ExampleViewController.swift
//  MovieApp
//
//  Created by Five on 27.03.2022..
//

import Foundation
import UIKit

class ExampleViewController: UIViewController {
    private var button: UIButton!
    private var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews() {
        label = UILabel()
        view.addSubview(label)
        label.text = "Labela"
        button = UIButton()
        view.addSubview(button)
        button.setTitle("Gumb", for: .normal)
    }
    private func styleViews() {
        view.backgroundColor = .lightGray
        label.textColor = .white
        button.backgroundColor = .blue
    }
    
    private func defineLayoutForViews() {
        let stackView = UIStackView()
        stackView.axis = .vertical // 1.
        stackView.alignment = .fill // 2.
        stackView.distribution = .fillEqually // 3.
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let view1 = createImageView()
        // view1.backgroundColor = .white
        let view4 = UIView()
        view4.backgroundColor = .red
        stackView.addArrangedSubview(view1) // 4.
        stackView.addArrangedSubview(view4)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func createImageView() -> UIView {
        let view1 = UIView()
        view1.backgroundColor = UIColor(patternImage: addImageToView("kv1-copy.png"))
        // view1.addSubview(UIImageView(image: addImageToView("kv1-copy.png")))
        
        let rating_label = UILabel()
        rating_label.frame = CGRect(x: 25, y: 150, width: 100, height: 100)
        rating_label.text = "90%"
        rating_label.font = UIFont.boldSystemFont(ofSize: 24)
        rating_label.textColor = .systemGreen
        
        
        let user_score_label = UILabel()
        user_score_label.frame = CGRect(x: 90, y:150, width: 200, height: 100)
        user_score_label.text = "User Score"
        user_score_label.font = UIFont.boldSystemFont(ofSize: 18)
        user_score_label.textColor = .black
        
        let movie_title_label = UILabel()
        movie_title_label.frame = CGRect(x: 25, y: 200 , width: 400, height: 100)
        movie_title_label.text = "Movie Title"
        movie_title_label.font = UIFont.boldSystemFont(ofSize: 30)
        movie_title_label.textColor = .black
        
        let movie_release_date_label = UILabel()
        movie_release_date_label.frame = CGRect(x: 25, y: 250 , width: 400, height: 100)
        movie_release_date_label.text = "Movie Date"
        movie_release_date_label.font = UIFont.boldSystemFont(ofSize: 18)
        movie_release_date_label.textColor = .black
        
        let movie_tags_label = UILabel()
        movie_tags_label.frame = CGRect(x: 25, y: 275 , width: 400, height: 100)
        movie_tags_label.text = "Movie Tags "
        movie_tags_label.font = UIFont.boldSystemFont(ofSize: 18)
        movie_tags_label.textColor = .black
        
        let movie_duration_label = UILabel()
        movie_duration_label.frame = CGRect(x: 150, y: 275 , width: 400, height: 100)
        movie_duration_label.text = "Movie Duration"
        movie_duration_label.font = UIFont.boldSystemFont(ofSize: 18)
        movie_duration_label.textColor = .black
        
        let movie_like_button = UIButton(type: .custom)
        movie_like_button.frame = CGRect(x: 25, y: 350, width: 40, height: 40)
        movie_like_button.backgroundColor = .darkGray
        movie_like_button.layer.cornerRadius = 0.5 * movie_like_button.bounds.size.width
        movie_like_button.clipsToBounds = true
        movie_like_button.layer.borderWidth = 0
        movie_like_button.layer.borderColor = UIColor.black.cgColor
        movie_like_button.setImage(UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        view1.addSubview(rating_label)
        view1.addSubview(user_score_label)
        view1.addSubview(movie_title_label)
        view1.addSubview(movie_release_date_label)
        view1.addSubview(movie_tags_label)
        view1.addSubview(movie_duration_label)
        view1.addSubview(movie_like_button)
        
        return view1
    }
    
    private func addImageToView(_ image_name : String) -> UIImage{
        let image : UIImage = UIImage(named: image_name)!
        let newSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        let rect = CGRect(origin: .zero, size: newSize)
            
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    private func createCollectionView() {
        let view1 = UIView()
        
    }
}
