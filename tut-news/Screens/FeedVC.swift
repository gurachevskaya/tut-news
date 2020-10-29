//
//  FeedVC.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    
    let control       = CustomSegmentedControl(frame: .zero, buttonTitles: ["All", "Saved"])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(control)
        configureControl()

    }
    
    
    private func configureControl() {
        control.translatesAutoresizingMaskIntoConstraints = false
        
//        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            control.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            control.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            control.heightAnchor.constraint(equalToConstant: 44),
            control.widthAnchor.constraint(equalToConstant: 250)
        ])
    }


}
