import Foundation
import UIKit

protocol appViewCastCollectionCommunication : AnyObject {
    func castDataLoaded()
}


class AppViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let textOverImageView = UIView()
    private let overviewView = UIView()
    private let mainView = UIView()
    
    private let rating_label = UILabel()
    private let movie_title_label = UITextView()
    private let movie_release_date_label = UILabel()
    private let movie_tags_label = UILabel()
    private let movie_duration_label = UILabel()
    private let overview_text = UITextView()
    private let imageView = UIImageView()
    private lazy var castCollectionView : CastCollectionView = {
        let castCollectionView = CastCollectionView()
        castCollectionView.appViewCollectionViewCommunicationDelegate = self
        return castCollectionView
    }()
    
    private let fontSizeBig = CGFloat(28)
    private let fontSizeMedium = CGFloat(16)
    private let fontSizeSmall = CGFloat(12)
    private let buttonSize = CGFloat(40)
    private let bigSpace = CGFloat(30)
    private let mediumSpace = CGFloat(20)
    private let smallSpace = CGFloat(10)
    private let extraSmallSpace = CGFloat(5)
    private let padding = CGFloat(20)
    private var movie : CategoryMovieModel?
    
    private let apiKey = "<api-key>"
    
    
    init(movie : CategoryMovieModel) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.movie = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavBar()
        
        if movie == nil {
            buildErrorView()
            return
        }

        getDataFromURL(requestUrl: "https://api.themoviedb.org/3/movie/"+String(movie!.id)+"?language=en-US&page=1&api_key="+apiKey)
        buildViews()
    }
    
    
    private func buildErrorView() {
        let errorView = UIView()
        errorView.backgroundColor = UIColor(red: 0.91, green: 0.93, blue: 0.96, alpha: 1.00)
        view.addSubview(errorView)
        errorView.snp.makeConstraints{ (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        
        let errorTextView = UITextView()
        errorTextView.backgroundColor = UIColor(red: 0.91, green: 0.93, blue: 0.96, alpha: 1.00)
        errorTextView.text = "Network error: something went wrong :("
        errorTextView.font = UIFont.systemFont(ofSize: 18)
        errorView.addSubview(errorTextView)
        
        errorTextView.snp.makeConstraints{ (make) in
            make.centerY.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
    }
    
    
    private func buildNavBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = UIColor(red: 0.04, green: 0.15, blue: 0.25, alpha: 1.00)

        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
    }
    
    
    private func buildViews() {
        view.addSubview(scrollView)
        view.backgroundColor = .white

        
        scrollView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
    
        
        createImageView()
        
        createCollectionView()
        
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
    
    
    private func createImageView() {
        scrollView.addSubview(textOverImageView)
        
        textOverImageView.snp.makeConstraints{ (make) in
            make.top.leading.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
//        POKUSAJ GRADIENTA (NIJE RESPONZIVAN)
//        let gradientLayer = CAGradientLayer()
//        DispatchQueue.main.async {
//            gradientLayer.frame = self.textOverImageView.bounds
//            gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor]
//            self.textOverImageView.layer.addSublayer(gradientLayer)
//        }
        
        textOverImageView.addSubview(imageView)
        imageView.snp.makeConstraints{ (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        
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
        
        
        user_rating_view.addSubview(rating_label)
        rating_label.translatesAutoresizingMaskIntoConstraints = false
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
        
        
        
        
        stackView.addArrangedSubview(movie_title_label)
        movie_title_label.font = UIFont.boldSystemFont(ofSize: fontSizeBig)
        movie_title_label.textColor = .white
        movie_title_label.isScrollEnabled = false
        movie_title_label.isEditable = false
        movie_title_label.backgroundColor = .clear
        
        
        
        let release_date_view = UIView()
        stackView.addArrangedSubview(release_date_view)
        
        release_date_view.addSubview(movie_release_date_label)
        movie_release_date_label.font = UIFont.systemFont(ofSize: fontSizeMedium)
        movie_release_date_label.textColor = .white
        movie_release_date_label.translatesAutoresizingMaskIntoConstraints = false
        movie_release_date_label.topAnchor.constraint(equalTo: release_date_view.topAnchor, constant: smallSpace).isActive = true
        movie_release_date_label.leadingAnchor.constraint(equalTo: release_date_view.leadingAnchor).isActive = true
        movie_release_date_label.bottomAnchor.constraint(equalTo: release_date_view.bottomAnchor).isActive = true
        
        
        
        let movie_tag_and_duration_view = UIView()
        stackView.addArrangedSubview(movie_tag_and_duration_view)
        
        
        movie_tag_and_duration_view.addSubview(movie_tags_label)
        
        movie_tags_label.font = UIFont.systemFont(ofSize: fontSizeMedium)
        movie_tags_label.textColor = .white
        movie_tags_label.translatesAutoresizingMaskIntoConstraints = false
        movie_tags_label.topAnchor.constraint(equalTo: movie_tag_and_duration_view.topAnchor).isActive = true
        movie_tags_label.leadingAnchor.constraint(equalTo: movie_tag_and_duration_view.leadingAnchor).isActive = true
        movie_tags_label.bottomAnchor.constraint(equalTo: movie_tag_and_duration_view.bottomAnchor).isActive = true
        movie_tags_label.adjustsFontSizeToFitWidth = true
        
        
        movie_tag_and_duration_view.addSubview(movie_duration_label)
        
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
        scrollView.addSubview(overviewView)
        overviewView.backgroundColor = .white
        
        overviewView.snp.makeConstraints{ (make) in
            make.leading.bottom.equalToSuperview()
            make.top.equalTo(textOverImageView.snp.bottom)
            make.width.equalToSuperview()
        }
        

        let overview_label = UILabel()
        overviewView.addSubview(overview_label)
        overview_label.text = "Overview"
        overview_label.font = UIFont.boldSystemFont(ofSize: fontSizeBig)
        overview_label.textColor = .black
        overview_label.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(bigSpace)
            make.leading.equalToSuperview().offset(padding)
        }
        
        
        overviewView.addSubview(overview_text)
        
        overview_text.font = UIFont.systemFont(ofSize: fontSizeMedium)
        overview_text.textColor = .black
        overview_text.isEditable = false
        overview_text.isSelectable = false
        overview_text.snp.makeConstraints{ (make) in
            make.top.equalTo(overview_label.snp.bottom).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(padding)
        }
        overview_text.isScrollEnabled = false
        
        
        
        overviewView.addSubview(castCollectionView)
        
        castCollectionView.snp.makeConstraints{ (make) in
            make.top.equalTo(overview_text.snp.bottom).offset(self.bigSpace)
            make.leading.equalToSuperview().offset(self.padding)
            make.trailing.equalToSuperview().inset(self.padding)
            make.bottom.equalToSuperview()
        }
        
        
        
        
    }
}


extension AppViewController : NetworkServiceProtocol {
    func getDataFromURL(requestUrl: String) {
        guard let url = URL(string: requestUrl) else { return  }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let networkService = NetworkService()
        networkService.executeUrlRequest(request) { dataValue, error in
            if error != nil {
                self.buildErrorView()
                return
            }
            guard let value = dataValue else {
                return
            }
            
            guard let value = try? JSONDecoder().decode(TMDBMovieModel.self, from: value) else {
                self.buildErrorView()
                return
            }
            
            let url = URL(string: "https://image.tmdb.org/t/p/original"+value.posterPath)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)!
                    }
                }
            }
            
            self.rating_label.text = String(Int(value.voteAverage*10))+"%"
            self.movie_title_label.text = value.title
            self.movie_release_date_label.text = value.releaseDate
            var movieTags = ""
            var counter = 0
            for genre in value.genres {
                if counter > 3 {
                    break
                }
                movieTags += genre.name + "  "
                counter += 1
            }
            self.movie_tags_label.text = movieTags
            self.movie_duration_label.text = String(value.runtime) + " m"
            self.overview_text.text = value.overview
            self.castCollectionView.getDataFromURL(requestUrl: "https://api.themoviedb.org/3/movie/"+String(value.id)+"/credits?api_key="+self.apiKey)
        }
    }
}


extension AppViewController : appViewCastCollectionCommunication {
    func castDataLoaded() {
        DispatchQueue.main.async {   // Hacky solution, please inform me if there is a better solution
            self.castCollectionView.snp.makeConstraints{ (make) in
                    make.height.equalTo(self.castCollectionView.collectionView.contentSize.height)
            }
        }
    }
}
