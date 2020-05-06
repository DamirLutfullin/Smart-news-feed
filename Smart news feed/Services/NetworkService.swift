//
//  NetworkManager.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 06.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation
import UIKit
import VKSdkFramework

class NetworkService {
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared.authService) {
        self.authService = authService
    }
    
    func getFeed() {
        var components = URLComponents()
        
        guard let token = authService.token else { return }
        let params = ["filters": "post,photo"]
        var allParams = params
        allParams["acces_token"] = token
        allParams["V"] = VKAPI.version
        
        components.scheme = VKAPI.scheme
        components.host = VKAPI.host
        components.path = VKAPI.newsFeed
        components.queryItems = allParams.map{URLQueryItem(name: $0, value: $1)}
        
        let url = components.url!
        
        print(url)
    }
}
