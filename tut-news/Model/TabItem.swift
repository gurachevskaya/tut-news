//
//  TabItem.swift
//  tut-news
//
//  Created by Karina on 10/30/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

enum TabItem: String, CaseIterable {
    case all = "All"
    case saved = "Saved"
    
    
    var viewController: UIViewController {
        switch self {
        case .all:
            return FeedVC()
        case .saved:
            return FavoritesViewController()
        }
    }
    
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
