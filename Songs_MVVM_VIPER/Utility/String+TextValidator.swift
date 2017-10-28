//
//  String+TextValidator.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation

extension String {
    var isValidUsername: Bool {
        return self.characters.count >= 6
    }
    
    var isValidPassword: Bool {
        return self.characters.count >= 6
    }
}
