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

class CastView: UIView {
    let stackView = UIStackView()
    let row1StackView = UIStackView()
    let row2StackView = UIStackView()
    
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
        backgroundColor = .white
        
        stackView.axis = .vertical
        stackView.spacing = 30
        addSubview(stackView)
        
        stackView.addArrangedSubview(row1StackView)
        row1StackView.axis = .horizontal
        row1StackView.distribution = .fillEqually
        row1StackView.alignment = .leading
        
        stackView.addArrangedSubview(row2StackView)
        row2StackView.axis = .horizontal
        row2StackView.distribution = .fillEqually
        row2StackView.alignment = .leading
    }
    
    
    func setLayout() {
        stackView.snp.makeConstraints {make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    
    func fetchMovieCast(movieId id: Int) {
        NetworkService.fetchMovieCast(movieId: id) {data in
            guard let castData = data else {
                return
            }
            
            for (index, crew) in castData.crew.enumerated() {
                if (index >= 6) {
                    break
                }
                
                let castCell = CastCell()
                castCell.setup(crew: crew)
                
                if (index < 3) {
                    self.row1StackView.addArrangedSubview(castCell)
                } else {
                    self.row2StackView.addArrangedSubview(castCell)
                }
                
            }
        }
    }

}

