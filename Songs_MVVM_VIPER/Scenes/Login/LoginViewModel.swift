//
//  LoginViewModel.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

protocol LoginViewModelProtocol {
    //MARK: - Input
    var username: Variable<String> { get }
    var password: Variable<String> { get }
    
    var loginTap: PublishSubject<Void> { get }
    
    //MARK: - Output
    var validInput: Driver<Bool> { get }
    var errors: Driver<AppError> { get }
    var loading: Driver<Bool> { get }
    var loginSuccessfully: Driver<Void> { get }
}

protocol LoginViewModelTransitionProtocol {
    var transition: Driver<LoginTransition> { get }
}

struct LoginCredential {
    let username: String
    let password: String
}


final class LoginViewModel: BaseViewModel, LoginViewModelProtocol, LoginViewModelTransitionProtocol {
    //MARK: - Input
    let username = Variable<String>("")
    let password = Variable<String>("")
    
    let loginTap = PublishSubject<Void>()
    
    //MARK: - Output
    let validInput: Driver<Bool>
    let errors: Driver<AppError>
    let loading: Driver<Bool>
    let loginSuccessfully: Driver<Void>
    
    //MARK: Coordinator
    let transition: Driver<LoginTransition>
    
    //MARK: - Service
    let loginService: LoginServiceProtocol
    
    //MARK: - Property
    fileprivate let activityIndicator = ActivityIndicator()
    
    init(loginService: LoginServiceProtocol) {
        self.loginService = loginService
        
        let usernameObservable = username.asObservable()
        let passwordObservable = password.asObservable()
        
        validInput = Observable.combineLatest(usernameObservable, passwordObservable) { $0.isValidUsername && $1.isValidPassword }
                        .asDriver(onErrorJustReturn: false)
                        .distinctUntilChanged()
        
        let loginCredential = Observable.combineLatest(usernameObservable, passwordObservable) { LoginCredential(username: $0, password: $1) }
        
        let loginResult = loginTap.asObservable()
                            .withLatestFrom(loginCredential)
                            .flatMapLatest { [loginService, activityIndicator] (credential) in
                                return loginService.login(username: credential.username, password: credential.password)
                                    .materialize().trackActivity(activityIndicator)
                            }
                            .share()
        
        errors = loginResult.errors()
                    .map { $0 as? AppError }
                    .unwrap()
                    .asDriver(onErrorDriveWith: .never())
        loginSuccessfully = loginResult.elements().asDriver(onErrorDriveWith: .never())
        
        transition = loginSuccessfully.map { LoginTransition.showSongScreen }
        
        loading = activityIndicator.asDriver()
        
        super.init()
    }
    
}

