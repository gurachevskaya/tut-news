//
//  AppError.swift
//  tut-news
//
//  Created by Karina on 10/29/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

enum AppError: String, Error {
    case unableToComplete       = "Unable to complete your request. Please check your internet connection."
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "The data recieved from the server was invalid. Please try again."
    case unableToFavourite      = "There was an error favouriting this news. Please try again."
    case alreadyInFavourites    = "You've already favourited this news."
}
