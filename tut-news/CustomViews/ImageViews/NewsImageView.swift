//
//  NewsImageView.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class NewsImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.placeholder
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(radius: CGFloat, frame: CGRect) {
        self.init(frame: .zero)
        layer.cornerRadius = radius
    }
    
    
    private func configure() {
        clipsToBounds               = true
        contentMode                 = .scaleAspectFill
        image                       = placeholderImage
        isUserInteractionEnabled    = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(fromURL url: String) {
        image = Images.placeholder
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            guard let image = image else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
