//
//  UIViewController+Ext.swift
//  tut-news
//
//  Created by Karina on 10/30/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default)
            alertVC.addAction(okAction)
            
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentLocationAlertOnMainThread() {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "Something went wrong.", message: "Please check your location settings for the app in Settings > Privacy > Location Services", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            alertVC.addAction(okAction)
            
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}

