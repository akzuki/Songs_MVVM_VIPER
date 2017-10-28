//
//  LoginCoordinator.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

enum LoginTransition: Transition {
    case showSongScreen
}

final class LoginCoordinator: BaseCoordinator, CoordinatorProtocol {
    fileprivate let disposeBag = DisposeBag()
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: LoginViewController
    
    var transition: Driver<LoginTransition>
    
    override init() {
        let loginService = LoginService()
        let loginViewModel = LoginViewModel(loginService: loginService)
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! LoginViewController
        loginViewController.inject(viewModel: loginViewModel)
        rootViewController = loginViewController
        
        transition = loginViewModel.transition
        
        super.init()
    }
    
    func start() {
        transition.drive(onNext: { [weak self] (transition) in
            self?.performTransition(transition: transition)
        }).disposed(by: disposeBag)
    }
    
    func performTransition(transition: LoginTransition) {
        switch transition {
        case .showSongScreen:
            let listSongViewController = ListSongWireframe.createListSongModule()
            rootViewController.present(listSongViewController, animated: false, completion: nil)
        }
    }
}


