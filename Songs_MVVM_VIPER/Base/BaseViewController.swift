//
//  BaseViewController.swift
//  Songs_MVVM_VIPER
//
//  Created by Hai Phan on 10/28/17.
//  Copyright © 2017 Hai Phan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loggingPrint("ViewController LOADED: \(self)")
    }
    
    deinit {
        loggingPrint("ViewController DEINIT: \(self)")
    }
}
