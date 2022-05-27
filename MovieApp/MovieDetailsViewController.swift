import Foundation
import UIKit


class MovieDetailsViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let textOverImageView = UIView()
    private let overviewView = UIView()
    private let mainView = UIView()
    
    private let ratingLabel = UILabel()
    private let movieTitleLabel = UITextView()
    private let movieReleaseDateLabel = UILabel()
    private let movieTagLabel = UILabel()
    private let movieDurationLabel = UILabel()
    private let overviewText = UITextView()
    private let imageView = UIImageView()
    private let castView = CastView()
    
    private let fontSizeBig = CGFloat(28)
    private let fontSizeMedium = CGFloat(16)
    private let fontSizeSmall = CGFloat(12)
    private let buttonSize = CGFloat(40)
    private let bigSpace = CGFloat(30)
    private let mediumSpace = CGFloat(20)
    private let smallSpace = CGFloat(10)
    private let extraSmallSpace = CGFloat(5)
    private let padding = CGFloat(20)
    private var movie : TMDBCategoryMovieModel?
    
    
    init(movie : TMDBCategoryMovieModel) {
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

        fetchMovieDetails()
        
        buildViews()
    }
    
    
    private func fetchMovieDetails() {
        NetworkService.fetchMovieDetails(movieId: movie!.id) {data in
            guard let movieData = data else {
                self.buildErrorView()
                return
            }
            
            let url = URL(string: "https://image.tmdb.org/t/p/original"+movieData.posterPath)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!) {
                    DispatchQueue.main.async {
                        self.imageView.contentMode = .scaleAspectFit
                        self.imageView.image = UIImage(data: data)!
                        self.setImageConstraint()
                    }
                }
            }
            
            self.ratingLabel.text = String(Int(movieData.voteAverage*10))+"%"
            self.movieTitleLabel.text = movieData.title
            self.movieReleaseDateLabel.text = movieData.releaseDate
            var movieTags = ""
            var counter = 0
            for genre in movieData.genres {
                if counter > 3 {
                    break
                }
                movieTags += genre.name + "  "
                counter += 1
            }
            self.movieTagLabel.text = movieTags
            self.movieDurationLabel.text = String(movieData.runtime) + " m"
            self.overviewText.text = movieData.overview
            self.castView.fetchMovieCast(movieId: movieData.id)
        }
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
            make.top.leading.trailing.bottom.width.equalToSuperview()
            make.height.equalTo(200)
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
        
        
        
        let emptyView = UIView()
        stackView.addArrangedSubview(emptyView)
        
        
        
        let userRatingView = UIView()
        stackView.addArrangedSubview(userRatingView)
        
        
        userRatingView.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.font = UIFont.boldSystemFont(ofSize: fontSizeMedium + 4)
        ratingLabel.textColor = .white
        ratingLabel.topAnchor.constraint(equalTo: userRatingView.topAnchor).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: userRatingView.leadingAnchor).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: userRatingView.bottomAnchor, constant: -smallSpace).isActive = true
        ratingLabel.adjustsFontSizeToFitWidth = true
        
        let userScoreLabel = UILabel()
        userRatingView.addSubview(userScoreLabel)
        userScoreLabel.text = "User Score"
        userScoreLabel.font = UIFont.boldSystemFont(ofSize: fontSizeMedium)
        userScoreLabel.textColor = .white
        userScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        userScoreLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: smallSpace).isActive = true
        userScoreLabel.topAnchor.constraint(equalTo: userRatingView.topAnchor).isActive = true
        userScoreLabel.bottomAnchor.constraint(equalTo: userRatingView.bottomAnchor, constant: -smallSpace).isActive = true
        userScoreLabel.adjustsFontSizeToFitWidth = true
        
        
        
        
        stackView.addArrangedSubview(movieTitleLabel)
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: fontSizeBig)
        movieTitleLabel.textColor = .white
        movieTitleLabel.isScrollEnabled = false
        movieTitleLabel.isEditable = false
        movieTitleLabel.backgroundColor = .clear
        
        
        
        let releaseDateView = UIView()
        stackView.addArrangedSubview(releaseDateView)
        
        releaseDateView.addSubview(movieReleaseDateLabel)
        movieReleaseDateLabel.font = UIFont.systemFont(ofSize: fontSizeMedium)
        movieReleaseDateLabel.textColor = .white
        movieReleaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        movieReleaseDateLabel.topAnchor.constraint(equalTo: releaseDateView.topAnchor, constant: smallSpace).isActive = true
        movieReleaseDateLabel.leadingAnchor.constraint(equalTo: releaseDateView.leadingAnchor).isActive = true
        movieReleaseDateLabel.bottomAnchor.constraint(equalTo: releaseDateView.bottomAnchor).isActive = true
        
        
        
        let movieTagAndDurationView = UIView()
        stackView.addArrangedSubview(movieTagAndDurationView)
        
        
        movieTagAndDurationView.addSubview(movieTagLabel)
        
        movieTagLabel.font = UIFont.systemFont(ofSize: fontSizeMedium)
        movieTagLabel.textColor = .white
        movieTagLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTagLabel.topAnchor.constraint(equalTo: movieTagAndDurationView.topAnchor).isActive = true
        movieTagLabel.leadingAnchor.constraint(equalTo: movieTagAndDurationView.leadingAnchor).isActive = true
        movieTagLabel.bottomAnchor.constraint(equalTo: movieTagAndDurationView.bottomAnchor).isActive = true
        movieTagLabel.adjustsFontSizeToFitWidth = true
        
        
        movieTagAndDurationView.addSubview(movieDurationLabel)
        
        movieDurationLabel.font = UIFont.boldSystemFont(ofSize: fontSizeMedium)
        movieDurationLabel.textColor = .white
        movieDurationLabel.translatesAutoresizingMaskIntoConstraints = false
        movieDurationLabel.topAnchor.constraint(equalTo: movieTagAndDurationView.topAnchor).isActive = true
        movieDurationLabel.leadingAnchor.constraint(equalTo: movieTagLabel.trailingAnchor, constant: extraSmallSpace).isActive = true
        movieDurationLabel.bottomAnchor.constraint(equalTo: movieTagAndDurationView.bottomAnchor).isActive = true
        movieDurationLabel.adjustsFontSizeToFitWidth = true
        
        
        
        let movieLikeButtonView = UIView()
        stackView.addArrangedSubview(movieLikeButtonView)
        movieLikeButtonView.translatesAutoresizingMaskIntoConstraints = false
        movieLikeButtonView.heightAnchor.constraint(equalToConstant: buttonSize + smallSpace).isActive = true
        let movieLikeButton = UIButton(type: .custom)
        movieLikeButtonView.addSubview(movieLikeButton)
        movieLikeButton.backgroundColor = .darkGray
        movieLikeButton.layer.cornerRadius = 0.5 * buttonSize
        movieLikeButton.clipsToBounds = true
        movieLikeButton.layer.borderWidth = 0
        movieLikeButton.setImage(UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        movieLikeButton.translatesAutoresizingMaskIntoConstraints = false
        movieLikeButton.centerYAnchor.constraint(equalTo: movieLikeButtonView.centerYAnchor).isActive = true
        movieLikeButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        movieLikeButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        
        let emptyView2 = UIView()
        stackView.addArrangedSubview(emptyView2)
        emptyView2.translatesAutoresizingMaskIntoConstraints = false
        emptyView2.heightAnchor.constraint(equalTo: textOverImageView.heightAnchor, multiplier: 0.035).isActive = true
    }
    
    
    private func createCollectionView() {
        scrollView.addSubview(overviewView)
        overviewView.backgroundColor = .white
        
        overviewView.snp.makeConstraints{ (make) in
            make.leading.bottom.equalToSuperview()
            make.top.equalTo(textOverImageView.snp.bottom)
            make.width.equalToSuperview()
        }
        

        let overviewLabel = UILabel()
        overviewView.addSubview(overviewLabel)
        overviewLabel.text = "Overview"
        overviewLabel.font = UIFont.boldSystemFont(ofSize: fontSizeBig)
        overviewLabel.textColor = .black
        overviewLabel.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(bigSpace)
            make.leading.equalToSuperview().offset(padding)
        }
        
        
        overviewView.addSubview(overviewText)
        
        overviewText.font = UIFont.systemFont(ofSize: fontSizeMedium)
        overviewText.textColor = .black
        overviewText.isEditable = false
        overviewText.isSelectable = false
        overviewText.snp.makeConstraints{ (make) in
            make.top.equalTo(overviewLabel.snp.bottom).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(padding)
        }
        overviewText.isScrollEnabled = false
        
        
        
        overviewView.addSubview(castView)
        
        castView.snp.makeConstraints{ (make) in
            make.top.equalTo(overviewText.snp.bottom).offset(self.bigSpace)
            make.leading.equalToSuperview().offset(self.padding)
            make.trailing.equalToSuperview().inset(self.padding)
            make.bottom.equalToSuperview()
        }
    }
    
    
    func setImageConstraint() {
        
        if imageView.image == nil {
            return
        }
        
        let myImageWidth = imageView.image!.size.width
        let myImageHeight = imageView.image!.size.height
        let myViewWidth = view.safeAreaLayoutGuide.layoutFrame.size.width

        let ratio = myViewWidth/myImageWidth
        let scaledHeight = myImageHeight * ratio
        
        imageView.snp.updateConstraints { (make) in
            make.height.equalTo(scaledHeight)
        }
    }
    
    

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.setImageConstraint()
        }, completion: nil)
    }
}

