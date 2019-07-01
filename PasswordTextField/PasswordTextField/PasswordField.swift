//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum StrengthLevel : String {
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
    
    // States of the pass word strength indicators
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
        
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 6
        self.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20.0)
        self.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40.0)
        self.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20.0)
        
        // Lay out your subviews here
        
        // 1. titleLabel
        //titleLabel.frame = CGRect(x: 0.0, y: 0.0, width: 150, height: 40)
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
            //titleLabel contraints
        NSLayoutConstraint.activate(
            [
                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin),
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin)
        ])
        // 2. textField
        //textField.frame = CGRect(x: 0, y: 40.0, width: 330, height: textFieldContainerHeight)
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 2.0
        textField.tintColor = textFieldBorderColor
        textField.isSecureTextEntry = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
            //textField constraints
        NSLayoutConstraint.activate ([
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldMargin),
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -textFieldMargin),
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
        textField.widthAnchor.constraint(equalToConstant: bounds.width - textFieldMargin * 2)
        ])
        // 2-1 button
        //howHideButton.frame = CGRect(x: 285.0, y: 10, width: 30.0, height: 30.0)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.layer.borderColor = UIColor.red.cgColor
        showHideButton.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(showHideButton)
        
            // button constraints
        showHideButton.topAnchor.constraint(equalTo: textField.topAnchor).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -standardMargin).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        showHideButton.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        showHideButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        // 3. indicator bars
            // 3-1 weakview
        //weakView.frame = CGRect(origin: CGPoint(x: standardMargin, y: 95.0), size: colorViewSize)
        weakView.backgroundColor = weakColor
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
                //weakview constraints
        weakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
            // 3-2 mediumview
        //mediumView.frame = CGRect(origin: CGPoint(x: colorViewSize.width + standardMargin * 2, y: 95.0), size: colorViewSize)
        mediumView.backgroundColor = .lightGray
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
                //mediumview constraints
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
            // 3-3 strongview
        //strongView.frame = CGRect(origin: CGPoint(x: colorViewSize.width * 2 + standardMargin * 3, y: 95.0), size: colorViewSize)
        strongView.backgroundColor = .lightGray
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
                // strongview constraints
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        // 4. indicator label
        //strengthDescriptionLabel.frame = CGRect(origin: CGPoint(x: colorViewSize.width * 3 + standardMargin * 4, y: 93.0), size: CGSize(width: colorViewSize.width * 2, height: colorViewSize.height * 2))
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = StrengthLevel.weak.rawValue
        strengthDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 11)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
            // indicator label constraints
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin - 2).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.widthAnchor.constraint(equalToConstant: colorViewSize.width * 2).isActive = true
        strengthDescriptionLabel.heightAnchor.constraint(equalToConstant: colorViewSize.height * 2).isActive = true

    }
    
    @objc func imageTapped() {
        //change image and show password
        
        if showHideButton.currentImage == UIImage(named: "eyes-closed") {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        } else {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
}


extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        // TODO: send new text to the determine strength method
        
        if newText.count <= 9 {
            if newText.isEmpty {
                weakBar()
            }
            mediumView.backgroundColor = .lightGray
            strongView.backgroundColor = .lightGray
            strengthDescriptionLabel.text = StrengthLevel.weak.rawValue

        } else if newText.count <= 19 && newText.count > 9 {
            if newText.count == 10 {
                if mediumView.backgroundColor != mediumColor {
                    mediumBar()
                }
            }
            strongView.backgroundColor = .lightGray
        } else if newText.count >= 20 {
            if newText.count == 20 {
                if strongView.backgroundColor != strongColor {
                    strongBar()
                }
            }
        }
        
        return true
    }
    
    func weakBar() {
        weakView.transform = CGAffineTransform(scaleX: 1.0, y: 1.4)
        UIView.animate(withDuration: 0.5) {
            self.weakView.transform = .identity
            self.strengthDescriptionLabel.text = StrengthLevel.weak.rawValue
        }
    }
    
    func mediumBar() {
        mediumView.transform = CGAffineTransform(scaleX: 1.0, y: 1.4)
        UIView.animate(withDuration: 0.5) {
            self.mediumView.transform = .identity
            self.mediumView.backgroundColor = self.mediumColor
            self.strengthDescriptionLabel.text = StrengthLevel.medium.rawValue
        }
    }
    
    func strongBar() {
        strongView.transform = CGAffineTransform(scaleX: 1.0, y: 1.4)
        UIView.animate(withDuration: 0.5) {
            self.strongView.transform = .identity
            self.strongView.backgroundColor = self.strongColor
            self.strengthDescriptionLabel.text = StrengthLevel.strong.rawValue
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.addTarget(self, action: #selector(passwordChange), for: .valueChanged)
        sendActions(for: .valueChanged)
        return false
    }
    
    @objc func passwordChange() {
        textField.text = self.password
    }
    
}
