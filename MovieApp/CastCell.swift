//
//  CastView.swift
//  MovieApp
//
//  Created by Five on 06.05.2022..
//

import Foundation
import UIKit


class CastCell: UIView {
    let stackView = UIStackView()
    let personTag = UILabel()
    let jobTag = UILabel()
    let fontSize = CGFloat(15)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildView()
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func buildView() {
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 5
        
        jobTag.textColor = .black
        jobTag.lineBreakMode = .byWordWrapping
        jobTag.numberOfLines = 5
        jobTag.font = UIFont.systemFont(ofSize: fontSize)
        
        personTag.font = UIFont.boldSystemFont(ofSize: fontSize)
        personTag.lineBreakMode = .byWordWrapping
        personTag.numberOfLines = 5
        personTag.textColor = .black

        
        addSubview(stackView)
        stackView.addArrangedSubview(personTag)
        stackView.addArrangedSubview(jobTag)
        
    }
    
    func setLayout() {
        stackView.snp.makeConstraints{ (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    func setup(crew: TMDBCrewModel) {
        personTag.text = crew.name
        jobTag.text = crew.job
    }
}
