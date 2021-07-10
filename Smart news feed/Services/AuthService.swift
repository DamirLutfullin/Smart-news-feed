//
//  AuthService.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 06.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: AnyObject {
    
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
    
}

class AuthService: NSObject, VKSdkUIDelegate, VKSdkDelegate {
    
    private let id = "7440920"
    private var vkSdk: VKSdk
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    var userId: String? {
        return VKSdk.accessToken()?.userId
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: id)
        super.init()
        vkSdk.uiDelegate = self
        vkSdk.register(self)
    }
    
    func wakeUpSession() {
        let scope = ["offline", "wall", "friends"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            switch state {
            case .initialized:
                VKSdk.authorize(scope)
            case .authorized:
                delegate?.authServiceSignIn()
            @unknown default:
                delegate?.authServiceSignInDidFail()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authServiceSignInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShouldShow(viewController: controller)
        
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    }
    
}
