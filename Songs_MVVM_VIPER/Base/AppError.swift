//
//  AppError.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation

enum AppError: Error {
    case invalidCredentials
    case cannotLoadSongs
}

extension AppError {
    var description: String {
        switch self {
        case .invalidCredentials:
            return "Invalid username/password"
        case .cannotLoadSongs:
            return "Cannot load songs"
        }
    }
}
