//
//  Helper.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import XCTest
@testable import Songs_MVVM_VIPER

final class Helper {
    static func equal(lhs: [SongProtocol], rhs: [SongProtocol]) {
        if lhs.count == rhs.count {
            if lhs.count == 0 {
                XCTAssert(true)
            } else {
                for i in 0...rhs.count-1 {
                    XCTAssert(lhs[i] == rhs[i])
                }
            }
        } else {
            XCTAssert(false)
        }
    }
}
