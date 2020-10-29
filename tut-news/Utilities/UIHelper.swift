//
//  UIHelper.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

enum UIHelper {
    
    static func createFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 48
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - minimumItemSpacing
        let itemWidth                   = availableWidth
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: 500)
        flowLayout.scrollDirection      = .horizontal
        
        return flowLayout
    }
}
