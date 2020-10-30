//
//  EmptyStateView.swift
//  tut-news
//
//  Created by Karina on 10/30/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    
    let messageLabel = TitleLabel(textAlignment: .center, fontSize: 28)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func configure() {
        addSubview(messageLabel)
        configureMessageLabel()
    }

    
    private func configureMessageLabel() {
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .white

        NSLayoutConstraint.activate([
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
        messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
        messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
        messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
