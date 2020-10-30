//
//  PersistenseManager.swift
//  tut-news
//
//  Created by Karina on 10/30/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenseManager {
    
    static private let defaults = UserDefaults.standard
    enum Keys { static let favourites = "favourites" }
    
    
    static func updateWith(favourite: News, actionType: PersistenceActionType, completed: @escaping (AppError?) -> Void) {
        retrieveFavourites { result in
            switch result {
            case .success(var favourites):
                
                switch actionType {
                case .add:
                    guard !favourites.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    
                    favourites.append(favourite)
                    
                case .remove:
                    favourites.removeAll { $0.newsUrl == favourite.newsUrl }
                }
                
                completed(saveFavourites(favourites: favourites))
                
            case.failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveFavourites(completed: @escaping (Result<[News], AppError>) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else { completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([News].self, from: favouritesData)
            completed(.success(favourites))
        } catch {
            completed(.failure(.unableToFavourite))
        }
    }
    
    
    static func saveFavourites(favourites: [News]) -> AppError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            defaults.set(encodedFavourites, forKey: Keys.favourites)
            return nil
        } catch {
            return .unableToFavourite
        }
    }
    
    
    static func isInFavs(news: News) -> Bool {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            return false
        }
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([News].self, from: favouritesData)
            
            for item in favourites {
                if item.link == news.link {
                    return true
                }
            }
        } catch {
            return false
        }
        return false
    }
}

