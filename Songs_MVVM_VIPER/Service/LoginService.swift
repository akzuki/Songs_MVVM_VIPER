//
//  LoginService.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginServiceProtocol {
    func login(username: String, password: String) -> Observable<Void>
}

class LoginService: LoginServiceProtocol {
    func login(username: String, password: String) -> Observable<Void> {
        return Observable.create { observer in
            DispatchQueue.global(qos: .background).async {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    if username == "username" && password == "password" {
                        observer.onNext(())
                        observer.onCompleted()
                    } else {
                        observer.onError(AppError.invalidCredentials)
                    }
                })
            }
            return Disposables.create()
        }
    }
}
