//
//  ExampleViewController.swift
//  MovieApp
//
//  Created by Five on 27.03.2022..
//

import Foundation
import UIKit


class ExampleViewController: UIViewController {
    let scrollView = UIScrollView()
    let fontSizeBig = CGFloat(28)
    let fontSizeMedium = CGFloat(18)
    let fontSizeSmall = CGFloat(14)
    let buttonSize = CGFloat(40)
    let bigSpace = CGFloat(30)
    let mediumSpace = CGFloat(20)
    let smallSpace = CGFloat(10)
    let extraSmallSpace = CGFloat(5)
    let padding = CGFloat(20) // needs to be scaled
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    private func buildViews() {
        defineLayoutForViews()
    }
    
    private func defineLayoutForViews() {
        let mainView = UIView()
        view.addSubview(mainView)
        mainView.addSubview(scrollView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.widthAnchor.constraint(equalTo: mainView.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        createImageView()
        
        let view4 = createCollectionView()
        view4.backgroundColor = .white
        
    }
    
    private func createImageView() {
        let view1 = UIView()
        scrollView.addSubview(view1)
        scrollView.backgroundColor = .gray
        
        
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        view1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        view1.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        view1.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1/2.25).isActive = true
        
        
        view1.backgroundColor = UIColor(patternImage: addImageToView("kv1-copy.png"))
        view1.backgroundColor = .white
        // view1.addSubview(UIImageView(image: addImageToView("kv1-copy.png")))
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view1.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view1.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view1.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.5).isActive = true
        
        
        
        // Star Button
        let movie_like_button = UIButton(type: .custom)
        view1.addSubview(movie_like_button)
        movie_like_button.backgroundColor = .darkGray
        movie_like_button.layer.cornerRadius = 0.5 * buttonSize
        movie_like_button.clipsToBounds = true
        movie_like_button.layer.borderWidth = 0
        movie_like_button.setImage(UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        movie_like_button.translatesAutoresizingMaskIntoConstraints = false
        movie_like_button.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: -padding).isActive = true
        movie_like_button.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: padding).isActive = true
        movie_like_button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        movie_like_button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        
        let movie_tags_label = UILabel()
        view1.addSubview(movie_tags_label)
        movie_tags_label.text = "Movie Tags"
        movie_tags_label.font = UIFont.systemFont(ofSize: fontSizeMedium)
        movie_tags_label.textColor = .black
        movie_tags_label.translatesAutoresizingMaskIntoConstraints = false
        movie_tags_label.bottomAnchor.constraint(equalTo: movie_like_button.topAnchor, constant: -mediumSpace).isActive = true
        movie_tags_label.leadingAnchor.constraint(equalTo: movie_like_button.leadingAnchor).isActive = true
        
        let movie_duration_label = UILabel()
        view1.addSubview(movie_duration_label)
        movie_duration_label.text = "Movie Duration"
        movie_duration_label.font = UIFont.boldSystemFont(ofSize: fontSizeMedium)
        movie_duration_label.textColor = .black
        movie_duration_label.translatesAutoresizingMaskIntoConstraints = false
        movie_duration_label.centerYAnchor.constraint(equalTo: movie_tags_label.centerYAnchor).isActive = true
        movie_duration_label.leadingAnchor.constraint(equalTo: movie_tags_label.trailingAnchor, constant: extraSmallSpace).isActive = true
        
        let movie_release_date_label = UILabel()
        view1.addSubview(movie_release_date_label)
        movie_release_date_label.text = "Movie Date"
        movie_release_date_label.font = UIFont.systemFont(ofSize: fontSizeMedium)
        movie_release_date_label.textColor = .black
        movie_release_date_label.translatesAutoresizingMaskIntoConstraints = false
        movie_release_date_label.leadingAnchor.constraint(equalTo: movie_tags_label.leadingAnchor).isActive = true
        movie_release_date_label.bottomAnchor.constraint(equalTo: movie_tags_label.topAnchor, constant: extraSmallSpace).isActive = true
        
        let movie_title_label = UILabel()
        view1.addSubview(movie_title_label)
        movie_title_label.text = "Movie Title"
        movie_title_label.font = UIFont.boldSystemFont(ofSize: fontSizeBig)
        movie_title_label.textColor = .black
        movie_title_label.translatesAutoresizingMaskIntoConstraints = false
        movie_title_label.bottomAnchor.constraint(equalTo: movie_release_date_label.bottomAnchor, constant: -bigSpace).isActive = true
        movie_title_label.leadingAnchor.constraint(equalTo: movie_tags_label.leadingAnchor).isActive = true
        
        let rating_label = UILabel()
        view1.addSubview(rating_label)
        rating_label.translatesAutoresizingMaskIntoConstraints = false
        rating_label.text = "90%"
        rating_label.font = UIFont.boldSystemFont(ofSize: fontSizeMedium)
        rating_label.textColor = .systemGreen
        rating_label.bottomAnchor.constraint(equalTo: movie_title_label.topAnchor, constant: -smallSpace).isActive = true
        rating_label.leadingAnchor.constraint(equalTo: movie_title_label.leadingAnchor).isActive = true
        
        
        let user_score_label = UILabel()
        view1.addSubview(user_score_label)
        user_score_label.text = "User Score"
        user_score_label.font = UIFont.boldSystemFont(ofSize: fontSizeSmall)
        user_score_label.textColor = .black
        user_score_label.translatesAutoresizingMaskIntoConstraints = false
        user_score_label.leadingAnchor.constraint(equalTo: rating_label.trailingAnchor, constant: extraSmallSpace).isActive = true
        user_score_label.topAnchor.constraint(equalTo: rating_label.topAnchor).isActive = true
        user_score_label.bottomAnchor.constraint(equalTo: rating_label.bottomAnchor).isActive = true
        
        
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
    
    
    private func createCollectionView() -> UIView {
        let view1 = UIView()
        view1.backgroundColor = .white
        
        let overview_label = UILabel()
        view1.addSubview(overview_label)
        overview_label.text = "Overview"
        overview_label.font = UIFont.boldSystemFont(ofSize: 30)
        overview_label.textColor = .black
        overview_label.translatesAutoresizingMaskIntoConstraints = false
        overview_label.topAnchor.constraint(equalTo: view1.topAnchor, constant: 30).isActive = true
        overview_label.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 30).isActive = true
        
        let overview_text = UITextView()
        view1.addSubview(overview_text)
        overview_text.text = "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil."
        overview_text.font = UIFont.systemFont(ofSize: 16)
        overview_text.textColor = .black
        overview_text.translatesAutoresizingMaskIntoConstraints = false
        overview_text.topAnchor.constraint(equalTo: overview_label.bottomAnchor, constant: 20).isActive = true
        overview_text.leadingAnchor.constraint(equalTo: overview_label.leadingAnchor).isActive = true
        overview_text.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -30).isActive = true
        overview_text.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        let person1 = createCastView(name: "Don Heck", job: "Characters")
        view1.addSubview(person1)
        person1.translatesAutoresizingMaskIntoConstraints = false
        person1.topAnchor.constraint(equalTo: overview_text.bottomAnchor, constant: 30).isActive = true
        person1.leadingAnchor.constraint(equalTo: overview_text.leadingAnchor).isActive = true

        let person2 = createCastView(name: "Jack Kirby", job: "Characters")
        view1.addSubview(person2)
        person2.translatesAutoresizingMaskIntoConstraints = false
        person2.topAnchor.constraint(equalTo: person1.topAnchor).isActive = true
        person2.leadingAnchor.constraint(equalTo: overview_text.leadingAnchor, constant: 100).isActive = true

        let person3 = createCastView(name: "John Favreau", job: "Director")
        view1.addSubview(person3)

        person3.translatesAutoresizingMaskIntoConstraints = false
        person3.topAnchor.constraint(equalTo: person1.topAnchor).isActive = true
        person3.leadingAnchor.constraint(equalTo: overview_text.leadingAnchor, constant: 200).isActive = true
        
        let person4 = createCastView(name: "Don Heck", job: "Characters")
        view1.addSubview(person4)
        person4.translatesAutoresizingMaskIntoConstraints = false
        person4.topAnchor.constraint(equalTo: person1.bottomAnchor, constant: 90).isActive = true
        person4.leadingAnchor.constraint(equalTo: overview_text.leadingAnchor).isActive = true

        let person5 = createCastView(name: "Jack Kirby", job: "Characters")
        view1.addSubview(person5)
        person5.translatesAutoresizingMaskIntoConstraints = false
        person5.topAnchor.constraint(equalTo: person4.topAnchor).isActive = true
        person5.leadingAnchor.constraint(equalTo: overview_text.leadingAnchor, constant: 100).isActive = true

        let person6 = createCastView(name: "John Favreau", job: "Director")
        view1.addSubview(person6)

        person6.translatesAutoresizingMaskIntoConstraints = false
        person6.topAnchor.constraint(equalTo: person4.topAnchor).isActive = true
        person6.leadingAnchor.constraint(equalTo: overview_text.leadingAnchor, constant: 200).isActive = true

        
        return view1
        
    }
    
    private func createCastView(name: String, job : String) -> UIView {
        let view1 = UIView()
        
        let person_tag = UILabel()
        view1.addSubview(person_tag)
        person_tag.text = name
        person_tag.font = UIFont.boldSystemFont(ofSize: 16)
        person_tag.textColor = .black
        person_tag.translatesAutoresizingMaskIntoConstraints = false
        person_tag.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
        person_tag.leadingAnchor.constraint(equalTo: view1.leadingAnchor).isActive = true
        
        
        let job_tag = UILabel()
        view1.addSubview(job_tag)
        job_tag.text = job
        job_tag.textColor = .black
        job_tag.translatesAutoresizingMaskIntoConstraints = false
        job_tag.topAnchor.constraint(equalTo: person_tag.bottomAnchor, constant: 10).isActive = true
        job_tag.leadingAnchor.constraint(equalTo: view1.leadingAnchor).isActive = true
        
        return view1
        
        
    }
}

