//
//  InitialViewController.swift
//  MovieApp
//
//  Created by Five on 24.03.2022..
//

import Foundation
import UIKit
class InitialViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        let screenSize : CGRect = UIScreen.main.bounds
        
        let rectangle = UIView(
        frame: CGRect(
        x: 0,
        y: 50,
        width: screenSize.width,
        height: 200))
        rectangle.backgroundColor = UIColor(red: 0.5, green: 0, blue: 0.9, alpha: 1)
        rectangle.layer.cornerRadius = 10
        rectangle.clipsToBounds = true
        
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 10, width: 100, height: 50)
        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = "Click the button"
        label.adjustsFontSizeToFitWidth = true
        rectangle.addSubview(label)
        
        
        let circle_button = UIButton()
        circle_button.frame = CGRect(x: 10, y: 80, width: 50, height: 50)
        circle_button.clipsToBounds = true
        circle_button.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.9)
        circle_button.setTitle("Ligma", for: .normal)
        rectangle.addSubview(circle_button)
        
        let testView : TestView = TestView(frame: CGRect(x: 30, y: 150, width: screenSize.width - 60, height: 50))
        rectangle.addSubview(testView)
        
        view.addSubview(rectangle)
        
        
        
        
        
    }
}
