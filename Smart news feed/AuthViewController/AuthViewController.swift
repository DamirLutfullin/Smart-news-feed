//
//  ViewController.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 30.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit
import VKSdkFramework

class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared.authService
        singInTouch()
    }

    @IBAction func singInTouch() {
        authService.wakeUpSession()
    }
}

