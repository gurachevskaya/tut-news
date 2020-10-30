//
//  FeedVC.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit
import CoreLocation

class FeedVC: DataLoadingVC {
    
    let control = CustomSegmentedControl(frame: .zero, buttonTypes: [.all, .saved])
    var collectionView: UICollectionView!
    var news: [News]    = []
    
    var locationManager: CLLocationManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.primary
        configureLocationManager()
        configureControl()
        configureCollectionView()
        getNews()
    }
    
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
    
    
    private func configureControl() {
        view.addSubview(control)
        control.delegate = self
        NSLayoutConstraint.activate([
            control.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        collectionView.backgroundColor = Colors.primary
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseID)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: control.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func getNews() {
        NetworkManager.shared.getNews { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let news):
                if self.news != news {
                    self.news = news
                    self.collectionView.reloadDataOnMainThread()
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    private func getFavNews() {
        PersistenseManager.retrieveFavourites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favourites):
                self.news = favourites
                self.collectionView.reloadDataOnMainThread()
//                self.updateUI(with: favourites)
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

//    private func updateUI(with favourites: [News]) {
//        self.news = favourites
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//            self.view.bringSubviewToFront(self.collectionView)
//        }
//        if favourites.isEmpty {
//            showEmptyStateView(with: "No favourites\nChoose one on the all screen.", in: collectionView)
//        }
//    }
}


extension FeedVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        news.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseID, for: indexPath) as! NewsCell
        let currentNews = news[indexPath.item]
        cell.set(news: currentNews)
        
        return cell
    }
}

extension FeedVC: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset                  = scrollView.contentOffset
        let inset                   = scrollView.contentInset
        let y: CGFloat              = offset.x - inset.left
        let reloadDistance: CGFloat = -75
        if y < reloadDistance && control.state == .all {
            getNews()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentNews = news[indexPath.item]
        let destVC      = NewsInfoViewController()
        destVC.news     = currentNews
        let navVC       = UINavigationController(rootViewController: destVC)
        present(navVC, animated: true)
    }
}


extension FeedVC: CustomSegmentedControlDelegate {
    
    func showAllNews() {
        getNews()
    }
    
    
    func showFavouritesNews() {
        getFavNews()
    }
}


extension FeedVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        } else if status == .denied || status == .restricted {
            presentLocationAlertOnMainThread()
        }
    }
}
