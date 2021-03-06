//
//  TitleLabel.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {

  override init(frame: CGRect) {
         super.init(frame: frame)
         configure()
     }
     
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     
     convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
         self.init(frame: .zero)
         self.textAlignment = textAlignment
         self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
     }
     
     
    private func configure() {
        textColor                   = .white
        adjustsFontSizeToFitWidth   = true
        numberOfLines               = 0
        minimumScaleFactor          = 0.75
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
