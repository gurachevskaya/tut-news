//
//  CustomSegmentedControl.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

enum ControlStates { case all, saved }

protocol CustomSegmentedControlDelegate: class {
    func showAllNews()
    func showFavouritesNews()
}

class CustomSegmentedControl: UIView {
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    private var buttonTypes: [TabItem]!
    var buttons: [UIButton]!
    
    var textColor: UIColor          = .systemGray2
    var selectedTextColor: UIColor  = .white
    
    var font: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    var selectedFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    var state: ControlStates!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    convenience init(frame: CGRect, buttonTypes: [TabItem]) {
        self.init(frame: frame)
        self.buttonTypes = buttonTypes
        createButtons()
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createButtons() {
        buttons = [UIButton]()
        
        for buttonType in buttonTypes {
            let button = UIButton(type: .system)
            button.setTitle(buttonType.rawValue, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            
            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            buttons.append(button)
            
            buttons[0].setTitleColor(selectedTextColor, for: .normal)
            buttons[0].titleLabel?.font = selectedFont
            state = .all
        }
    }

    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: buttons)
        
        stack.axis          = .horizontal
        stack.alignment     = .fill
        stack.distribution  = .fillEqually
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.pinToEdges(of: self)
    }
    
    
    @objc func buttonAction(sender: UIButton) {
        if sender.titleLabel?.text == TabItem.all.rawValue {
            delegate?.showAllNews()
            state = .all
            
        } else if sender.titleLabel?.text == TabItem.saved.rawValue {
            delegate?.showFavouritesNews()
            state = .saved
        }
        
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
