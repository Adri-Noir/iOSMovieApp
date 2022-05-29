//
//  SearchBarView.swift
//  MovieApp
//
//  Created by Five on 09.04.2022..
//

import Foundation
import UIKit
import SnapKit
import XCTest


class SearchBarView: UIView {
    weak var delegate: SearchBoxActions?
    let magnifyingGlassPadding = 10
    let searchWithoutCancelView = UIView()
    let searchIcon = UIImageView()
    let searchBox = UITextField()
    let cancelButton = UIButton()
    let clearButton = UIButton()
    var emptyTextBox = true;

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    private func buildView() {
        buildEmptyTextBox()
    }
    
    private func buildEmptyTextBox() {
        addSubview(searchWithoutCancelView)
        searchWithoutCancelView.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
        searchWithoutCancelView.layer.cornerRadius = 10
        searchWithoutCancelView.clipsToBounds = true
        searchWithoutCancelView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        
        searchIcon.image = UIImage(systemName: "magnifyingglass")!.withTintColor(.black, renderingMode: .alwaysOriginal)
        searchWithoutCancelView.addSubview(searchIcon)
        searchIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(magnifyingGlassPadding)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(searchIcon.snp.height)
        }
        
        
        searchBox.delegate = self
        searchBox.placeholder = "Search"
        searchBox.autocapitalizationType = .none
        searchBox.autocorrectionType = .no
        searchWithoutCancelView.addSubview(searchBox)
        searchBox.snp.makeConstraints { (make) in
            make.centerY.trailing.height.equalToSuperview()
            make.leading.equalTo(searchIcon.snp.trailing).offset(magnifyingGlassPadding)
        }
        
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitleColor(.gray, for: .highlighted)
        cancelButton.contentHorizontalAlignment = .center
        cancelButton.titleLabel?.adjustsFontSizeToFitWidth = true
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        cancelButton.alpha = 0;
        
        
        clearButton.setImage(UIImage(systemName: "xmark")!.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        clearButton.setImage(UIImage(systemName: "xmark")!.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .highlighted)
        clearButton.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
    }
    
    private func buildEditingTextBox() {
        addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
            make.trailing.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.searchWithoutCancelView.snp.remakeConstraints { (make) in
                make.top.bottom.leading.equalToSuperview()
                make.trailing.equalTo(self.cancelButton.snp.leading).offset(-self.magnifyingGlassPadding)
            }
            
            self.searchWithoutCancelView.superview?.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveLinear) {
            self.cancelButton.alpha = 1.0;
            
            self.cancelButton.superview?.layoutIfNeeded()
        }
        
    }
    
    
    private func clearButtonLayout() {
        searchWithoutCancelView.addSubview(clearButton)
        clearButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-magnifyingGlassPadding)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(clearButton.snp.height)
        }
        
        
        searchBox.snp.remakeConstraints { (make) in
            make.leading.equalTo(searchIcon.snp.trailing).offset(magnifyingGlassPadding)
            make.centerY.height.equalToSuperview()
            make.trailing.equalTo(clearButton.snp.leading).offset(5 - magnifyingGlassPadding)
        }
    }
    
    private func removeClearButton() {
        clearButton.removeFromSuperview()
        searchBox.snp.remakeConstraints { (make) in
            make.leading.equalTo(searchIcon.snp.trailing).offset(magnifyingGlassPadding)
            make.centerY.height.trailing.equalToSuperview()
        }
    }
    
    
    @objc private func cancelAction() {
        delegate?.userClearedText()
        delegate?.userPressedCancel()
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.cancelButton.alpha = 0;
            
            self.cancelButton.superview?.layoutIfNeeded()
        }
        cancelButton.removeFromSuperview()
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.searchWithoutCancelView.snp.remakeConstraints { (make) in
                make.top.bottom.leading.trailing.equalToSuperview()
            }
            
            self.searchWithoutCancelView.superview?.layoutIfNeeded()
        }
        
        searchBox.text = ""
        removeClearButton()
        searchBox.resignFirstResponder()
    }
    
    
    @objc private func clearAction() {
        searchBox.text = ""
        removeClearButton()
        delegate?.userClearedText()
    }

    
}


extension SearchBarView : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        buildEditingTextBox()
        delegate?.userClearedText()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.isEmpty ?? true {
            clearButtonLayout()
        }
        if textField.text?.count == 1 && string.elementsEqual("") {
            removeClearButton()
            delegate?.userTyped(textBoxText: "")
            return true
        }
        
        if string.elementsEqual("") {
            let text = textField.text ?? ""
            let index = text.index(text.endIndex, offsetBy: -1)
            delegate?.userTyped(textBoxText: String(text.prefix(upTo: index)))
        } else {
            let text = textField.text ?? ""
            delegate?.userTyped(textBoxText: text + string)
        }
        
        return true
    }
}
