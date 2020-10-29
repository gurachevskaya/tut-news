//
//  NetworkManager.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    static let shared   = NetworkManager()
    private let baseUrl = "https://news.tut.by/rss/index.rss"
    let cache           = NSCache<NSString, UIImage>()
    let parser          = NewsLParser()
   
    
    private override init() {}
    
    
    func getNews(completed: @escaping (Result<[News], AppError>) -> Void) {
        
        guard let url = URL(string: baseUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            self.parser.parseNews(data: data) { result in
                switch result {
                case .success(let news):
                    completed(.success(news))
                case .failure(let error):
                    completed(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}

