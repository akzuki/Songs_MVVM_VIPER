//
//  BaseCoordinator.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Transition
protocol Transition {}

//MARK: - Coordinator
protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    public func addChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    public func removeChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}

//MARK: - RootViewControllerProvider
protocol RootViewControllerProvider: class {
    associatedtype RootViewController: UIViewController
    var rootViewController: RootViewController { get }
    
    func start()
    
    associatedtype T: Transition
    func performTransition(transition: T)
}

typealias CoordinatorProtocol = Coordinator & RootViewControllerProvider


//MARK: - Base Coordinator
class BaseCoordinator {
    init() {
        loggingPrint("Coordinator INIT: \(self)")
    }
    
    deinit {
        loggingPrint("Coordinator DEINIT: \(self)")
    }
}

