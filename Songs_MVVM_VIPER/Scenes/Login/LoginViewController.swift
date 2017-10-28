//
//  LoginViewController.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: BaseViewController {
    fileprivate let disposeBag = DisposeBag()
    //MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    fileprivate var loginViewModel: LoginViewModelProtocol!
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    fileprivate func bindViewModel() {
        //bind input
        usernameTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: loginViewModel.username)
            .disposed(by: disposeBag)
        passwordTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: loginViewModel.password)
            .disposed(by: disposeBag)
        loginButton.rx.tap
            .bind(to: loginViewModel.loginTap)
            .disposed(by: disposeBag)
        //bind output
        loginViewModel.validInput
            .do(onNext: { [weak self] (validInput) in
                self?.loginButton.backgroundColor = validInput ? UIColor.white : UIColor.white.withAlphaComponent(0.5)
            })
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        loginViewModel.errors
            .drive(onNext: { [weak self] (error) in
                let alertVC = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alertVC.addAction(cancelAction)
                self?.present(alertVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        loginViewModel.loading
            .do(onNext: { [weak self] (isLoading) in
                self?.view.isUserInteractionEnabled = !isLoading
            })
            .drive(loadingActivityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func inject(viewModel: LoginViewModelProtocol) {
        self.loginViewModel = viewModel
    }
}
