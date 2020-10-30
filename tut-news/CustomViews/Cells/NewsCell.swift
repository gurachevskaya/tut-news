//
//  NewsCell.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    static let reuseID  = "NewsCell"
    
    let newsImageView       = NewsImageView(radius: 8, frame: .zero)
    let authorLabel         = SecondaryLabel(textAlignment: .left, fontSize: 14)
    let dateLabel           = SecondaryLabel(textAlignment: .right, fontSize: 14)
    let titleLabel          = TitleLabel(textAlignment: .center, fontSize: 24)
    let descriptionLabel    = SecondaryLabel(textAlignment: .left, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(news: News) {
        newsImageView.downloadImage(fromURL: news.newsUrl)
        authorLabel.text        = news.author
        dateLabel.text          = news.pubDate.convertToDisplayFormat()
        titleLabel.text         = news.title
        descriptionLabel.text   = news.description
        descriptionLabel.addInterlineSpacing()
    }
    
    
    private func configure() {
        addSubviews(newsImageView, authorLabel, dateLabel, titleLabel, descriptionLabel)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            newsImageView.heightAnchor.constraint(equalToConstant: 400),
            
            authorLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: padding),
            authorLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: padding),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 15),
            
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -padding),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
}
