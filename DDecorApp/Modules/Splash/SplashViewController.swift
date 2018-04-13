//
//  SplashViewController.swift
//  DDecorApp
//
//  Created by Durgesh Pandey on 12/04/18.
//  Copyright © 2018 DDecor. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigateToLoginScreen()

    }

    func navigateToLoginScreen() {
        
        //Load Login Screen
        AppInstances.appDelegate.loadLoginScreen()
    }
    
}
