//
//  News.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

struct News: Codable, Hashable {
    
    var title: String
    var link: String
    var description: String
    var author: String
    var pubDate: String
    var newsUrl: String
    
    
    init(with dictionary: [String: Any]) {
        self.title          = dictionary["title"] as? String ?? ""
        self.link           = dictionary["link"] as? String ?? ""
        let currDescription = dictionary["description"] as? String ?? ""
        self.description    = currDescription.slice(from: ">", to: "<") ?? currDescription
        self.author         = dictionary["atom:name"] as? String ?? ""
        self.pubDate        = dictionary["pubDate"] as? String ?? ""
        self.newsUrl        = dictionary["newsUrl"] as? String ?? ""
    }
}
