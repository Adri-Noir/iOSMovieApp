//
//  TestView.swift
//  MovieApp
//
//  Created by Five on 24.03.2022..
//

import Foundation
import UIKit

class TestView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        let textbox1 = UITextView()
        textbox1.frame = CGRect(x: 10, y: 10, width: frame.width - 20, height: frame.height - 20)
        textbox1.text = "Ligma balls bitch"
        textbox1.textAlignment = .center
        textbox1.backgroundColor = .gray
        textbox1.textColor = .white
        textbox1.font = .systemFont(ofSize: 15)
        
        addSubview(textbox1)
        
        
    }
}
