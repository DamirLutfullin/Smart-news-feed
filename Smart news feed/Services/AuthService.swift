//
//  AuthService.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 06.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
    
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
    
}

class AuthService: NSObject, VKSdkUIDelegate, VKSdkDelegate {
    
    private let id = "7440920"
    private var vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: id)
        super.init()
        print("VKSdk.initialize")
        vkSdk.uiDelegate = self
        vkSdk.register(self)
    }
    
    weak var delegate: AuthServiceDelegate?
    
    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { (state, error) in
            switch state {
            case .initialized:
                print(".initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print(".authorized")
            case .unknown:
                print(".unknown")
            case .pending:
                print(".pending")
            case .external:
                print(".external")
            case .safariInApp:
                print(".safariInApp")
            case .webview:
                print(".webview")
            case .error:
                print(".error")
            @unknown default:
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        delegate?.authServiceSignIn()
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
        
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
