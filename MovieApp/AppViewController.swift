import Foundation
import UIKit


class AppViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let textOverImageView = UIView()
    private let overviewView = UIView()
    private let mainView = UIView()
    
    private let fontSizeBig = CGFloat(28)
    private let fontSizeMedium = CGFloat(16)
    private let fontSizeSmall = CGFloat(12)
    private let buttonSize = CGFloat(40)
    private let bigSpace = CGFloat(30)
    private let mediumSpace = CGFloat(20)
    private let smallSpace = CGFloat(10)
    private let extraSmallSpace = CGFloat(5)
    private let padding = CGFloat(20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        buildViews()
        updateContentSizeScrollView()
    }
    
    private func buildViews() {
        scrollView.addSubview(mainView)
        view.addSubview(scrollView)
        view.backgroundColor = .white
        scrollView.bounces = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        
        createImageView()
        
        createCollectionView()
    }
    
    
    private func createImageView() {
        mainView.addSubview(textOverImageView)
        
        
        textOverImageView.translatesAutoresizingMaskIntoConstraints = false
        textOverImageView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        textOverImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        textOverImageView.widthAnchor.constraint(equalTo: mainView.widthAnchor).isActive = true
        textOverImageView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 1/2.05).isActive = true
        
//        POKUSAJ GRADIENTA (NIJE RESPONZIVAN)
//        let gradientLayer = CAGradientLayer()
//        DispatchQueue.main.async {
//            gradientLayer.frame = self.textOverImageView.bounds
//            gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor]
//            self.textOverImageView.layer.addSublayer(gradientLayer)
//        }
        
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        textOverImageView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: textOverImageView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: textOverImageView.leadingAnchor, constant: padding).isActive = true
        stackView.bottomAnchor.constraint(equalTo: textOverImageView.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: textOverImageView.trailingAnchor, constant: -padding).isActive = true
        
        
        
        let empty_view = UIView()
        stackView.addArrangedSubview(empty_view)
        
        
        
        let user_rating_view = UIView()
        stackView.addArrangedSubview(user_rating_view)
        
        let rating_label = UILabel()
        user_rating_view.addSubview(rating_label)
        rating_label.translatesAutoresizingMaskIntoConstraints = false
        rating_label.text = "76%"
        rating_label.font = UIFont.boldSystemFont(ofSize: fontSizeMedium + 4)
        rating_label.textColor = .white
        rating_label.topAnchor.constraint(equalTo: user_rating_view.topAnchor).isActive = true
        rating_label.leadingAnchor.constraint(equalTo: user_rating_view.leadingAnchor).isActive = true
        rating_label.bottomAnchor.constraint(equalTo: user_rating_view.bottomAnchor, constant: -smallSpace).isActive = true
        rating_label.adjustsFontSizeToFitWidth = true
        
        let user_score_label = UILabel()
        user_rating_view.addSubview(user_score_label)
        user_score_label.text = "User Score"
        user_score_label.font = UIFont.boldSystemFont(ofSize: fontSizeMedium)
        user_score_label.textColor = .white
        user_score_label.translatesAutoresizingMaskIntoConstraints = false
        user_score_label.leadingAnchor.constraint(equalTo: rating_label.trailingAnchor, constant: smallSpace).isActive = true
        user_score_label.topAnchor.constraint(equalTo: user_rating_view.topAnchor).isActive = true
        user_score_label.bottomAnchor.constraint(equalTo: user_rating_view.bottomAnchor, constant: -smallSpace).isActive = true
        user_score_label.adjustsFontSizeToFitWidth = true
        
        
        
        let movie_title_label = UILabel()
        stackView.addArrangedSubview(movie_title_label)
        movie_title_label.text = "Iron Man (2008)"
        movie_title_label.font = UIFont.boldSystemFont(ofSize: fontSizeBig)
        movie_title_label.textColor = .white
        movie_title_label.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        let release_date_view = UIView()
        stackView.addArrangedSubview(release_date_view)
        let movie_release_date_label = UILabel()
        release_date_view.addSubview(movie_release_date_label)
        movie_release_date_label.text = "05/02/2008 (US)"
        movie_release_date_label.font = UIFont.systemFont(ofSize: fontSizeMedium)
        movie_release_date_label.textColor = .white
        movie_release_date_label.translatesAutoresizingMaskIntoConstraints = false
        movie_release_date_label.topAnchor.constraint(equalTo: release_date_view.topAnchor, constant: smallSpace).isActive = true
        movie_release_date_label.leadingAnchor.constraint(equalTo: release_date_view.leadingAnchor).isActive = true
        movie_release_date_label.bottomAnchor.constraint(equalTo: release_date_view.bottomAnchor).isActive = true
        
        
        
        let movie_tag_and_duration_view = UIView()
        stackView.addArrangedSubview(movie_tag_and_duration_view)
        
        let movie_tags_label = UILabel()
        movie_tag_and_duration_view.addSubview(movie_tags_label)
        movie_tags_label.text = "Action, Science Fiction, Adventure"
        movie_tags_label.font = UIFont.systemFont(ofSize: fontSizeMedium)
        movie_tags_label.textColor = .white
        movie_tags_label.translatesAutoresizingMaskIntoConstraints = false
        movie_tags_label.topAnchor.constraint(equalTo: movie_tag_and_duration_view.topAnchor).isActive = true
        movie_tags_label.leadingAnchor.constraint(equalTo: movie_tag_and_duration_view.leadingAnchor).isActive = true
        movie_tags_label.bottomAnchor.constraint(equalTo: movie_tag_and_duration_view.bottomAnchor).isActive = true
        movie_tags_label.adjustsFontSizeToFitWidth = true
        
        let movie_duration_label = UILabel()
        movie_tag_and_duration_view.addSubview(movie_duration_label)
        movie_duration_label.text = "2h 6m"
        movie_duration_label.font = UIFont.boldSystemFont(ofSize: fontSizeMedium)
        movie_duration_label.textColor = .white
        movie_duration_label.translatesAutoresizingMaskIntoConstraints = false
        movie_duration_label.topAnchor.constraint(equalTo: movie_tag_and_duration_view.topAnchor).isActive = true
        movie_duration_label.leadingAnchor.constraint(equalTo: movie_tags_label.trailingAnchor, constant: extraSmallSpace).isActive = true
        movie_duration_label.bottomAnchor.constraint(equalTo: movie_tag_and_duration_view.bottomAnchor).isActive = true
        movie_duration_label.adjustsFontSizeToFitWidth = true
        
        
        
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
        empty_view_2.translatesAutoresizingMaskIntoConstraints = false
        empty_view_2.heightAnchor.constraint(equalTo: textOverImageView.heightAnchor, multiplier: 0.035).isActive = true
    }
    
    
    private func createCollectionView() {
        mainView.addSubview(overviewView)
        overviewView.backgroundColor = .white
        
        overviewView.translatesAutoresizingMaskIntoConstraints = false
        overviewView.topAnchor.constraint(equalTo: textOverImageView.bottomAnchor).isActive = true
        overviewView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        overviewView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        overviewView.widthAnchor.constraint(equalTo: mainView.widthAnchor).isActive = true
        
        

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
        overview_text.isSelectable = false
        overview_text.translatesAutoresizingMaskIntoConstraints = false
        overview_text.topAnchor.constraint(equalTo: overview_label.bottomAnchor, constant: padding).isActive = true
        overview_text.leadingAnchor.constraint(equalTo: overview_label.leadingAnchor).isActive = true
        overview_text.trailingAnchor.constraint(equalTo: overviewView.trailingAnchor, constant: -padding).isActive = true
        overview_text.isScrollEnabled = false
        
        
        
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
        stackViewLower.bottomAnchor.constraint(equalTo: overviewView.bottomAnchor).isActive = true
        
        
        
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
    
    
    private func updateContentSizeScrollView() {
        DispatchQueue.main.async {
            self.scrollView.contentSize.height = self.mainView.frame.size.height
        }
    }
    
    
    private func addBackgroundImage() {
        let image = UIImage(named: "ironman_cover")
        textOverImageView.backgroundColor = UIColor(patternImage: image!)
        
    }

}
