//
//  VKNewsFeedInteractor.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 07.05.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol VKNewsFeedBusinessLogic {
    func makeRequest(request: VKNewsFeed.Model.Request.RequestType)
}

class VKNewsFeedInteractor: VKNewsFeedBusinessLogic {
    
    var presenter: VKNewsFeedPresentationLogic?
    var service: VKNewsFeedService?
    private var fetcher =  NetworkDataFetcher(networking:NetworkService())
    
    func makeRequest(request: VKNewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = VKNewsFeedService()
        }
        switch request {
        case .getNewsFeed:
            fetcher.getFeed { [weak self] (response) in
                guard let response = response else { return }
                self?.presenter?.presentData(response: .presentNewsFeed(feedResponse: response))
            }
        }
    }
    
}
