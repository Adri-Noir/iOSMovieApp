//
//  ExampleViewController.swift
//  MovieApp
//
//  Created by Five on 27.03.2022..
//

import Foundation
import UIKit


class ExampleViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let textOverImageView = UIView()
    private let overviewView = UIView()
    
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
        
        createCollectionView()
        // let view4 = createCollectionView()
        // view4.backgroundColor = .white
        
    }
    
    private func createImageView() {
        scrollView.addSubview(textOverImageView)
        // scrollView.backgroundColor = .gray
        
        
        textOverImageView.translatesAutoresizingMaskIntoConstraints = false
        textOverImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        textOverImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        textOverImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        textOverImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1/2.25).isActive = true
        
        
        textOverImageView.backgroundColor = UIColor(patternImage: addImageToView("kv1-copy.png"))
        textOverImageView.backgroundColor = .white
        // view1.addSubview(UIImageView(image: addImageToView("kv1-copy.png")))
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        textOverImageView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: textOverImageView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: textOverImageView.leadingAnchor, constant: padding).isActive = true
        stackView.bottomAnchor.constraint(equalTo: textOverImageView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: textOverImageView.widthAnchor).isActive = true
        
        let empty_view = UIView()
        stackView.addArrangedSubview(empty_view)
        //empty_view.backgroundColor = .blue
        
        
        
        let user_rating_view = UIView()
        stackView.addArrangedSubview(user_rating_view)
        
        let rating_label = UILabel()
        user_rating_view.addSubview(rating_label)
        rating_label.translatesAutoresizingMaskIntoConstraints = false
        rating_label.text = "90%"
        rating_label.font = UIFont.boldSystemFont(ofSize: fontSizeMedium)
        rating_label.textColor = .systemGreen
        rating_label.topAnchor.constraint(equalTo: user_rating_view.topAnchor).isActive = true
        rating_label.leadingAnchor.constraint(equalTo: user_rating_view.leadingAnchor).isActive = true
        rating_label.bottomAnchor.constraint(equalTo: user_rating_view.bottomAnchor).isActive = true
        rating_label.adjustsFontSizeToFitWidth = true
        
        let user_score_label = UILabel()
        user_rating_view.addSubview(user_score_label)
        user_score_label.text = "  User Score"
        user_score_label.font = UIFont.boldSystemFont(ofSize: fontSizeSmall)
        user_score_label.textColor = .black
        user_score_label.translatesAutoresizingMaskIntoConstraints = false
        user_score_label.leadingAnchor.constraint(equalTo: rating_label.trailingAnchor).isActive = true
        user_score_label.topAnchor.constraint(equalTo: user_rating_view.topAnchor).isActive = true
        user_score_label.bottomAnchor.constraint(equalTo: user_rating_view.bottomAnchor).isActive = true
        // user_score_label.trailingAnchor.constraint(equalTo: user_rating_view.trailingAnchor).isActive = true
        
        
        
        let movie_title_label = UILabel()
        stackView.addArrangedSubview(movie_title_label)
        movie_title_label.text = "Movie Title"
        movie_title_label.font = UIFont.boldSystemFont(ofSize: fontSizeBig)
        movie_title_label.textColor = .black
        movie_title_label.translatesAutoresizingMaskIntoConstraints = false
        movie_title_label.adjustsFontSizeToFitWidth = true
        
        
        
        let release_date_view = UIView()
        stackView.addArrangedSubview(release_date_view)
        let movie_release_date_label = UILabel()
        release_date_view.addSubview(movie_release_date_label)
        movie_release_date_label.text = "Movie Date"
        movie_release_date_label.font = UIFont.systemFont(ofSize: fontSizeMedium)
        movie_release_date_label.textColor = .black
        movie_release_date_label.translatesAutoresizingMaskIntoConstraints = false
        movie_release_date_label.topAnchor.constraint(equalTo: release_date_view.topAnchor, constant: smallSpace).isActive = true
        movie_release_date_label.leadingAnchor.constraint(equalTo: release_date_view.leadingAnchor).isActive = true
        movie_release_date_label.bottomAnchor.constraint(equalTo: release_date_view.bottomAnchor).isActive = true
        movie_release_date_label.adjustsFontSizeToFitWidth = true
        
        
        
        let movie_tag_and_duration_view = UIView()
        stackView.addArrangedSubview(movie_tag_and_duration_view)
        
        let movie_tags_label = UILabel()
        movie_tag_and_duration_view.addSubview(movie_tags_label)
        movie_tags_label.text = "Movie Tags"
        movie_tags_label.font = UIFont.systemFont(ofSize: fontSizeMedium)
        movie_tags_label.textColor = .black
        movie_tags_label.translatesAutoresizingMaskIntoConstraints = false
        movie_tags_label.topAnchor.constraint(equalTo: movie_tag_and_duration_view.topAnchor).isActive = true
        movie_tags_label.leadingAnchor.constraint(equalTo: movie_tag_and_duration_view.leadingAnchor).isActive = true
        movie_tags_label.bottomAnchor.constraint(equalTo: movie_tag_and_duration_view.bottomAnchor).isActive = true
        movie_tags_label.adjustsFontSizeToFitWidth = true
        
        let movie_duration_label = UILabel()
        movie_tag_and_duration_view.addSubview(movie_duration_label)
        movie_duration_label.text = " Movie Duration"
        movie_duration_label.font = UIFont.boldSystemFont(ofSize: fontSizeMedium)
        movie_duration_label.textColor = .black
        movie_duration_label.translatesAutoresizingMaskIntoConstraints = false
        movie_duration_label.topAnchor.constraint(equalTo: movie_tag_and_duration_view.topAnchor).isActive = true
        movie_duration_label.leadingAnchor.constraint(equalTo: movie_tags_label.trailingAnchor).isActive = true
        movie_duration_label.bottomAnchor.constraint(equalTo: movie_tag_and_duration_view.bottomAnchor).isActive = true
        // movie_duration_label.trailingAnchor.constraint(equalTo: movie_tag_and_duration_view.trailingAnchor).isActive = true
        movie_duration_label.adjustsFontSizeToFitWidth = true
        
        
        
        // Star Button
        let movie_like_button_view = UIView()
        stackView.addArrangedSubview(movie_like_button_view)
        movie_like_button_view.translatesAutoresizingMaskIntoConstraints = false
        movie_like_button_view.heightAnchor.constraint(equalToConstant: buttonSize + smallSpace).isActive = true
        let movie_like_button = UIButton(type: .custom)
        movie_like_button_view.addSubview(movie_like_button)
        movie_like_button.backgroundColor = .darkGray
        movie_like_button.layer.cornerRadius = 0.5 * buttonSize
        movie_like_button.clipsToBounds = true
        movie_like_button.layer.borderWidth = 0
        movie_like_button.setImage(UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        movie_like_button.translatesAutoresizingMaskIntoConstraints = false
        movie_like_button.centerYAnchor.constraint(equalTo: movie_like_button_view.centerYAnchor).isActive = true
        movie_like_button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        movie_like_button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        
        let empty_view_2 = UIView()
        stackView.addArrangedSubview(empty_view_2)
        //empty_view_2.backgroundColor = .blue
        empty_view_2.translatesAutoresizingMaskIntoConstraints = false
        empty_view_2.heightAnchor.constraint(equalTo: textOverImageView.heightAnchor, multiplier: 0.035).isActive = true
        
        
        
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
        scrollView.addSubview(overviewView)
        
        overviewView.translatesAutoresizingMaskIntoConstraints = false
        overviewView.topAnchor.constraint(equalTo: textOverImageView.bottomAnchor).isActive = true
        overviewView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        overviewView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1).isActive = true
        overviewView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        overviewView.backgroundColor = .white

        let overview_label = UILabel()
        overviewView.addSubview(overview_label)
        overview_label.text = "Overview"
        overview_label.font = UIFont.boldSystemFont(ofSize: fontSizeBig)
        overview_label.textColor = .black
        overview_label.translatesAutoresizingMaskIntoConstraints = false
        overview_label.topAnchor.constraint(equalTo: overviewView.topAnchor, constant: bigSpace).isActive = true
        overview_label.leadingAnchor.constraint(equalTo: overviewView.leadingAnchor, constant: padding).isActive = true
        
        let overview_text = UITextView()
        overviewView.addSubview(overview_text)
        overview_text.text = "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil."
        overview_text.font = UIFont.systemFont(ofSize: fontSizeMedium)
        overview_text.textColor = .black
        overview_text.isEditable = false
        overview_text.translatesAutoresizingMaskIntoConstraints = false
        overview_text.topAnchor.constraint(equalTo: overview_label.bottomAnchor, constant: padding).isActive = true
        overview_text.leadingAnchor.constraint(equalTo: overview_label.leadingAnchor).isActive = true
        overview_text.trailingAnchor.constraint(equalTo: overviewView.trailingAnchor, constant: -padding).isActive = true
        overview_text.isScrollEnabled = false
        // overview_text.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1/4).isActive = true
        
        
        
        let stackViewUpper = UIStackView()
        stackViewUpper.backgroundColor = .white
        overviewView.addSubview(stackViewUpper)
        stackViewUpper.axis = .horizontal
        stackViewUpper.alignment = .center
        stackViewUpper.distribution = .fillEqually
        stackViewUpper.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewUpper.topAnchor.constraint(equalTo: overview_text.bottomAnchor, constant: bigSpace).isActive = true
        stackViewUpper.leadingAnchor.constraint(equalTo: overview_label.leadingAnchor).isActive = true
        stackViewUpper.trailingAnchor.constraint(equalTo: overviewView.trailingAnchor, constant: -padding).isActive = true
        
        
        let person1 = createCastView(name: "Don Heck", job: "Characters")
        stackViewUpper.addArrangedSubview(person1)
        
        let person2 = createCastView(name: "Jack Kirby", job: "Characters")
        stackViewUpper.addArrangedSubview(person2)

        let person3 = createCastView(name: "John Favreau", job: "Director")
        stackViewUpper.addArrangedSubview(person3)
        
        
        let stackViewLower = UIStackView()
        stackViewLower.backgroundColor = .white
        overviewView.addSubview(stackViewLower)
        stackViewLower.axis = .horizontal
        stackViewLower.alignment = .center
        stackViewLower.distribution = .fillEqually
        stackViewLower.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewLower.topAnchor.constraint(equalTo: stackViewUpper.bottomAnchor, constant: bigSpace).isActive = true
        stackViewLower.leadingAnchor.constraint(equalTo: overview_label.leadingAnchor).isActive = true
        stackViewLower.trailingAnchor.constraint(equalTo: overviewView.trailingAnchor, constant: -padding).isActive = true
        
        let person4 = createCastView(name: "Don Heck", job: "Screenplay")
        stackViewLower.addArrangedSubview(person4)

        let person5 = createCastView(name: "Jack Marcum", job: "Screenplay")
        stackViewLower.addArrangedSubview(person5)

        let person6 = createCastView(name: "Matt Holloway", job: "Screenplay")
        stackViewLower.addArrangedSubview(person6)

        
    }
    
    private func createCastView(name: String, job : String) -> UIView {
        let view1 = UIView()
        
        let person_tag = UITextView()
        view1.addSubview(person_tag)
        person_tag.text = name
        person_tag.isEditable = false
        person_tag.isScrollEnabled = false
        person_tag.font = UIFont.boldSystemFont(ofSize: fontSizeMedium - 1)
        person_tag.textColor = .black
        
        person_tag.translatesAutoresizingMaskIntoConstraints = false
        person_tag.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
        person_tag.leadingAnchor.constraint(equalTo: view1.leadingAnchor).isActive = true
        person_tag.trailingAnchor.constraint(equalTo: view1.trailingAnchor).isActive = true
        
        
        let job_tag = UITextView()
        view1.addSubview(job_tag)
        job_tag.text = job
        job_tag.textColor = .black
        job_tag.isEditable = false
        job_tag.isScrollEnabled = false
        job_tag.font = UIFont.systemFont(ofSize: fontSizeMedium - 1)
        job_tag.translatesAutoresizingMaskIntoConstraints = false
        job_tag.topAnchor.constraint(equalTo: person_tag.bottomAnchor).isActive = true
        job_tag.leadingAnchor.constraint(equalTo: view1.leadingAnchor).isActive = true
        job_tag.trailingAnchor.constraint(equalTo: view1.trailingAnchor).isActive = true
        job_tag.bottomAnchor.constraint(equalTo: view1.bottomAnchor).isActive = true
        
        return view1
        
        
    }
}

