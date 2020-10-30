//
//  NewsInfoViewController.swift
//  tut-news
//
//  Created by Karina on 10/30/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class NewsInfoViewController: UIViewController {
    
    let scrollView          = UIScrollView()
    let contentView         = UIView()
    
    let newsImageView       = NewsImageView(frame: .zero)
    let authorLabel         = SecondaryLabel(textAlignment: .left, fontSize: 14)
    let dateLabel           = SecondaryLabel(textAlignment: .right, fontSize: 14)
    let titleLabel          = TitleLabel(textAlignment: .center, fontSize: 24)
    let descriptionLabel    = SecondaryLabel(textAlignment: .left, fontSize: 16)
    
    let shareButton         = UIButton()
    let saveButton          = UIButton()
    var buttons: [UIButton] = []
    
    var news: News!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        configureButtons()
        set(news: news)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureUIElements()
    }
    
    
    func configureViewController() {
        view.backgroundColor = Colors.primary
        let doneButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func configureScrollView() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    
    func configureButtons() {
        buttons = [saveButton, shareButton]
        
        for button in buttons {
            newsImageView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tintColor = .white
        }
        
        saveButton.setImage(SFSymbols.save, for: .normal)
        shareButton.setImage(SFSymbols.share, for: .normal)
        
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
    }

    
    @objc func didTapSaveButton() {
         print("didTapSaveButton")
    }
    
    
    @objc func didTapShareButton() {
           print("didTapShareButton")
       }
       
    
    func set(news: News) {
           newsImageView.downloadImage(fromURL: news.newsUrl)
           newsImageView.contentMode = .scaleAspectFill
           authorLabel.text        = news.author
           dateLabel.text          = news.pubDate.convertToDisplayFormat()
           titleLabel.text         = news.title
           descriptionLabel.text   = news.description
           descriptionLabel.addInterlineSpacing()
       }
    
    
    func configureUIElements() {
        contentView.addSubviews(newsImageView, authorLabel, dateLabel, titleLabel, descriptionLabel)
        let padding: CGFloat = 8
        
        let ratio: CGFloat
        if let image = newsImageView.image {
            ratio = image.size.height / image.size.width
        } else {
            ratio = 1
        }
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImageView.heightAnchor.constraint(equalTo: newsImageView.widthAnchor, multiplier: ratio),
            
            shareButton.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: -padding),
            shareButton.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: -padding),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            
            saveButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -padding),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            saveButton.bottomAnchor.constraint(equalTo: shareButton.bottomAnchor),
            
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
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
}
