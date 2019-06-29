//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum StrrengthLevel : String {
    case weak = "Too weak"
    case medium = "Could be stronger"
    case strong = "Strong password"
}


class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        
        // Lay out your subviews here
        
        // 1. titleLabel
        titleLabel.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 2. textField
        textField.frame = CGRect(x: 0, y: 25.0, width: 330, height: textFieldContainerHeight)
        textField.textColor = labelTextColor
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 2.0
        
        
        addSubview(textField)
        // 2-1 button
        showHideButton.frame = CGRect(x: 290.0, y: 10.0, width: 30.0, height: 30.0)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.layer.borderColor = UIColor.red.cgColor
        showHideButton.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        textField.addSubview(showHideButton)
        
        // 3. indicator bars
        weakView.frame = CGRect(origin: CGPoint(x: 0, y: 90.0), size: colorViewSize)
        weakView.backgroundColor = weakColor
        addSubview(weakView)
        
        mediumView.frame = CGRect(origin: CGPoint(x: colorViewSize.width + 5, y: 90.0), size: colorViewSize)
        mediumView.backgroundColor = .lightGray
        addSubview(mediumView)
        
        strongView.frame = CGRect(origin: CGPoint(x: colorViewSize.width * 2 + 5 + 5, y: 90.0), size: colorViewSize)
        strongView.backgroundColor = .lightGray
        addSubview(strongView)
        
        // 4. indicator label
        strengthDescriptionLabel.frame = CGRect(origin: CGPoint(x: colorViewSize.width * 3 + 5 + 5 + 7, y: 90.0), size: CGSize(width: colorViewSize.width * 2, height: 10.00))
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = StrrengthLevel.weak.rawValue
        strengthDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 15)
        addSubview(strengthDescriptionLabel)
        
    }
    
    @objc func imageTapped() {
        //change image and show password
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
