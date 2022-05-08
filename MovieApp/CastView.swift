//
//  CastView.swift
//  MovieApp
//
//  Created by Five on 06.05.2022..
//

import Foundation
import UIKit


class CastView: UICollectionViewCell {
    let stackView = UIStackView()
    let personTag = UITextView()
    let jobTag = UITextView()
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
        
        jobTag.textColor = .black
        jobTag.isEditable = false
        jobTag.isScrollEnabled = false
        jobTag.font = UIFont.systemFont(ofSize: fontSize)
        
        personTag.isEditable = false
        personTag.isScrollEnabled = false
        personTag.font = UIFont.boldSystemFont(ofSize: fontSize)
        personTag.textColor = .black
        
        let emptyView = UIView()
        
        addSubview(stackView)
        stackView.addArrangedSubview(personTag)
        stackView.addArrangedSubview(jobTag)
        stackView.addArrangedSubview(emptyView)
    }
    
    func setLayout() {
        stackView.snp.makeConstraints{ (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    func setup(name: String, job: String) {
        personTag.text = name
        jobTag.text = job
    }
}
