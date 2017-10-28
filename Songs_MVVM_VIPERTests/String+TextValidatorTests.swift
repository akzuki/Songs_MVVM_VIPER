//
//  String+TextValidatorTests.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import XCTest
@testable import Songs_MVVM_VIPER

class String_TextValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_validate_username() {
        XCTAssertFalse("".isValidUsername, "Empty string is NOT valid username")
        XCTAssertFalse("abcde".isValidUsername, "Username must be at least 6 characters")
        
        XCTAssert("123456".isValidUsername, "Username must be at least 6 characters")
    }
    
    func test_validate_password() {
        XCTAssertFalse("".isValidPassword, "Empty string is NOT valid password")
        XCTAssertFalse("abcde".isValidPassword, "Password must be at least 6 characters")
        
        XCTAssert("123456".isValidPassword, "Username must be at least 6 characters")
        XCTAssert("abc123!@#".isValidPassword, "Username must be at least 6 characters")
    }
    
}
