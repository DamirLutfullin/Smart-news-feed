//
//  WebImageView.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 08.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    func set(imageURL: String?) {
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            return }
        if let cacheResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cacheResponse.data)
            return
        }
        
        URLSession.shared.dataTask(with: url) {[weak self ] (data, response, error) in
            guard let data = data, let response = response else { return }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
                self?.handleLoadedImage(data: data, response: response)
            }
        }.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
