//
//  FeedVC.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    
    let control = CustomSegmentedControl(frame: .zero, buttonTitles: ["All", "Saved"])
    var collectionView: UICollectionView!
    var news: [News] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        configureControl()
        
        NetworkManager.shared.getNews { result in
            switch result {
            case .success(let news):
                self.news = news
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        configureCollectionView()
    }
    
    
    private func configureControl() {
        view.addSubview(control)
        
        NSLayoutConstraint.activate([
            control.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            control.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            control.heightAnchor.constraint(equalToConstant: 44),
            control.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGray5
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseID)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: control.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension FeedVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        news.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseID, for: indexPath) as! NewsCell
        cell.set(news: news[indexPath.item])
        return cell
    }
}

extension FeedVC: UICollectionViewDelegate {
    
    //    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //        let offsetY       = scrollView.contentOffset.y
    //        let contentHeight = scrollView.contentSize.height
    //        let height        = scrollView.frame.size.height
    //
    //        if offsetY > contentHeight - height {
    //            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
    //            page += 1
    //            getFollowers(username: username, page: page)
    //        }
    //    }
    //
    //
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let activeArray = isSearching ? filteredFollowers : followers
    //        let follower    = activeArray[indexPath.item]
    //
    //        let destVC      = UserInfoVC()
    //        destVC.delegate = self
    //        destVC.username = follower.login
    //        let navVC       = UINavigationController(rootViewController: destVC)
    //        present(navVC, animated: true)
    //    }
}
