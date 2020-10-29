//
//  CustomSegmentedControl.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class CustomSegmentedControl: UIView {
    
    private var buttonTitles: [String]!
    private var buttons: [UIButton]!
    
    var textColor: UIColor = .secondaryLabel
    var selectedTextColor: UIColor = .label
    
    var font: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    var selectedFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    convenience init(frame: CGRect, buttonTitles: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitles
        createButtons()
        configureStackView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createButtons() {
        buttons = [UIButton]()
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            
            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            buttons.append(button)
            
            buttons[0].setTitleColor(selectedTextColor, for: .normal)
            buttons[0].titleLabel?.font = selectedFont
        }
    }

    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    @objc func buttonAction(sender: UIButton) {
        for button in buttons {
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = font
            if button == sender {
                button.setTitleColor(selectedTextColor, for: .normal)
                button.titleLabel?.font = selectedFont
            }
        }
    }
}
