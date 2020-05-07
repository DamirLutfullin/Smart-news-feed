//
//  NetworkDataFetcher.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 07.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters" : "post, photo"]
        networking.request(path: VKAPI.newsFeed, params: params) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            let decoded = self.decodeJSON(type: VKFeedResponseWrapped.self, data: data)
            response(decoded?.response)
        }
    }
    
    private func decodeJSON <T : Decodable> (type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}

