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
    
    let newsImageView   = NewsImageView(frame: .zero)
    let authorLabel     = SecondaryLabel(fontSize: 16)
    let dateLabel       = SecondaryLabel(fontSize: 16)
    let titleLabel      = TitleLabel(textAlignment: .center, fontSize: 20)
    let descriptionLabel       = SecondaryLabel(fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(news: News) {
        newsImageView.downloadImage(fromURL: news.newsUrl!)
        authorLabel.text = news.author
        dateLabel.text = "" //change to date
        titleLabel.text = news.title
        descriptionLabel.text = news.description
    }
    
    
    private func configure() {
        addSubviews(newsImageView, authorLabel, dateLabel, titleLabel, descriptionLabel)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            newsImageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            authorLabel.heightAnchor.constraint(equalToConstant: 50),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
}
