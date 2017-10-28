//
//  Result.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(AppError)
}
