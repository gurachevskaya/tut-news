//
//  UICollectionViewController.swift
//  tut-news
//
//  Created by Karina on 10/30/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
}
