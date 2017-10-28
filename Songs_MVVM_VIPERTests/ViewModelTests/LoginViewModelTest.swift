//
//  LoginViewModelTest.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest

@testable import Songs_MVVM_VIPER

class LoginViewModelTest: XCTestCase {
    fileprivate var subject: LoginViewModel!
    fileprivate var loginServiceMock: LoginServiceProtocol!
    fileprivate var testScheduler: TestScheduler!
    fileprivate var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        testScheduler = nil
        subject = nil
        disposeBag = nil
    }
    
    /// Test case: When user presses log in button, logs in successfully. Expect the transition to be .showSongScreen
    func test_login_successfully() {
//        SharingScheduler.mock(scheduler: testScheduler) {
//
//        }
        
        //given
        let loginServiceMock = LoginServiceMock(loginResult: [Observable.just(())])
        subject = LoginViewModel(loginService: loginServiceMock)
        
        let loginResult = testScheduler.createObserver(Bool.self)
        let loading = testScheduler.createObserver(Bool.self)
        let errors = testScheduler.createObserver(AppError.self)
        let transition = testScheduler.createObserver(LoginTransition.self)
        
        subject.loginSuccessfully.map { true }.drive(loginResult).disposed(by: disposeBag)
        subject.errors.drive(errors).disposed(by: disposeBag)
        subject.transition.drive(transition).disposed(by: disposeBag)
        subject.loading.drive(loading).disposed(by: disposeBag)
        
        //when
        let tap = testScheduler.createHotObservable([next(100, ())])
        tap.bind(to: subject.loginTap).disposed(by: disposeBag)
        testScheduler.start()
        
        //then
        XCTAssertEqual(loginResult.events,
                       [next(100, true)])
        XCTAssertEqual(transition.events,
                       [next(100, LoginTransition.showSongScreen)])
        XCTAssertEqual(loading.events,
                       [next(0, false),
                        next(100, true),
                        next(100, false)])
        XCTAssertEqual(errors.events, [])
    }
    
    /// Test case: When user presses log in button. login fails. Expect errors to be .invalidCredentials
    func test_login_failed_invalid_credential() {
        //given
        let loginServiceMock = LoginServiceMock(loginResult: [Observable.error(AppError.invalidCredentials)])
        subject = LoginViewModel(loginService: loginServiceMock)
        
        let loginResult = testScheduler.createObserver(Bool.self)
        let loading = testScheduler.createObserver(Bool.self)
        let errors = testScheduler.createObserver(AppError.self)
        let transition = testScheduler.createObserver(LoginTransition.self)
        
        subject.loginSuccessfully.map { true }.drive(loginResult).disposed(by: disposeBag)
        subject.errors.drive(errors).disposed(by: disposeBag)
        subject.loading.drive(loading).disposed(by: disposeBag)
        subject.transition.drive(transition).disposed(by: disposeBag)
        
        //when
        let tap = testScheduler.createHotObservable([next(100, ())])
        tap.bind(to: subject.loginTap).disposed(by: disposeBag)
        testScheduler.start()
        
        //then
        XCTAssertEqual(loginResult.events, [])
        XCTAssertEqual(transition.events, [])
        XCTAssertEqual(loading.events,
                       [next(0, false),
                        next(100, true),
                        next(100, false)])
        XCTAssertEqual(errors.events, [next(100, AppError.invalidCredentials)])
    }
    
    /// Test case: When users presses log in button. The first time fails, 2nd time succeeds. Expect errors to be .invalidCredential then transition be .showSongScreen
    func test_login_fail_then_success() {
        //given
        let loginServiceMock = LoginServiceMock(loginResult: [Observable.error(AppError.invalidCredentials), Observable.just(())])
        subject = LoginViewModel(loginService: loginServiceMock)
        
        let loginResult = testScheduler.createObserver(Bool.self)
        let loading = testScheduler.createObserver(Bool.self)
        let errors = testScheduler.createObserver(AppError.self)
        let transition = testScheduler.createObserver(LoginTransition.self)
        
        subject.loginSuccessfully.map { true }.drive(loginResult).disposed(by: disposeBag)
        subject.errors.drive(errors).disposed(by: disposeBag)
        subject.loading.drive(loading).disposed(by: disposeBag)
        subject.transition.drive(transition).disposed(by: disposeBag)
        
        //when
        let tap = testScheduler.createHotObservable([next(100, ()), next(200, ())])
        tap.bind(to: subject.loginTap).disposed(by: disposeBag)
        testScheduler.start()
        
        //then
        XCTAssertEqual(loginResult.events,
                       [next(200, true)])
        XCTAssertEqual(transition.events,
                       [next(200, .showSongScreen)])
        XCTAssertEqual(loading.events,
                       [next(0, false),
                        next(100, true),
                        next(100, false),
                        next(200, true),
                        next(200, false)])
        XCTAssertEqual(errors.events, [next(100, AppError.invalidCredentials)])
    }
    
    /// Test case: When user inputs username and password 4 times
    /// - 1st: empty username and password -> Expect validInput to be false
    /// - 2nd: "abcde" username and password -> Expect validInput to be false
    /// - 3rd: "abcdef" username and password -> Expect validInput to be true
    /// - 4th: "111" username and password -> Expect validInput to be false
    func test_input_validation() {
        //given
        subject = LoginViewModel(loginService: LoginService())
        //input
        let usernameInput = testScheduler.createHotObservable([next(100, ""), next(200, "abcde"), next(300, "abcdef"), next(400, "111")])
        let passwordInput = testScheduler.createHotObservable([next(100, ""), next(200, "abcde"), next(300, "abcdef"), next(400, "111")])
        //output
        let validInput = testScheduler.createObserver(Bool.self)
        let loginResult = testScheduler.createObserver(Bool.self)
        let loading = testScheduler.createObserver(Bool.self)
        let errors = testScheduler.createObserver(AppError.self)
        let transition = testScheduler.createObserver(LoginTransition.self)
        
        subject.validInput.drive(validInput).disposed(by: disposeBag)
        subject.loginSuccessfully.map { true }.drive(loginResult).disposed(by: disposeBag)
        subject.errors.drive(errors).disposed(by: disposeBag)
        subject.loading.drive(loading).disposed(by: disposeBag)
        subject.transition.drive(transition).disposed(by: disposeBag)
        
        //when
        usernameInput.bind(to: subject.username).disposed(by: disposeBag)
        passwordInput.bind(to: subject.password).disposed(by: disposeBag)
        
        testScheduler.start()
        
        //then
        XCTAssertEqual(validInput.events,
                       [next(0, false),
                        next(300, true),
                        next(400, false)])
        XCTAssertEqual(loginResult.events, [])
        XCTAssertEqual(transition.events, [])
        XCTAssertEqual(errors.events, [])
    }
}

final class LoginServiceMock: LoginServiceProtocol {
    fileprivate var loginResult: [Observable<Void>]
    
    init(loginResult: [Observable<Void>]) {
        self.loginResult = loginResult
    }
    
    func login(username: String, password: String) -> Observable<Void> {
        return loginResult.removeFirst()
    }
}
