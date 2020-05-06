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

protocol Networking {
    func request(path: String, params:  [String: String], completion: @escaping  (Data?, Error?) -> () )
}

class NetworkService: Networking {
    
    private let authService: AuthService
    var components = URLComponents()
    
    init(authService: AuthService = SceneDelegate.shared.authService) {
        self.authService = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> ()) {
        guard let token = authService.token else { return }
        let params = ["filters": "post,photo"]
        var allParams = params
        allParams["acces_token"] = token
        allParams["V"] = VKAPI.version
        let url = self.url(from: path, param: allParams)
        let task = createDataTask(from: url, completion: completion)
        task.resume()
       
    }
    
    private func createDataTask(from url: URL, completion: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
       return URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                    completion(data, error)
                }
            }
    }
    
    private func url(from path: String, param: [String: String]) -> URL {
            components.scheme = VKAPI.scheme
            components.host = VKAPI.host
            components.path = path
            components.queryItems = param.map{URLQueryItem(name: $0, value: $1)}
            
        return components.url!
    }
}
