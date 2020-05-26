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
    private var revealdedPostsIds = [Int]()
    private var feedResponse: FeedResponse?
    
    func makeRequest(request: VKNewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = VKNewsFeedService()
        }
        switch request {
        case .getNewsFeed:
            fetcher.getFeed { [weak self] (response) in
                self?.feedResponse = response
                self?.presentFeed()
            }
        case .revealCellFromPostId(postId: let postId):
            revealdedPostsIds.append(postId)
            presentFeed()
        case .getUserPhotoUrl:
            print(".getUserPhotoUrl")
            fetcher.getUser { [weak self] (respone) in
                guard let photoUrl = respone?.photo100 else { return }
                self?.presenter?.presentData(response: VKNewsFeed.Model.Response.ResponseType.presentUserPhoto(photoUrl: photoUrl))
                print(photoUrl)
            }
        }
    }
    
    private func presentFeed() {
        guard let response = self.feedResponse else { return }
        presenter?.presentData(response: .presentNewsFeed(feedResponse: response, revealdedPostIds: revealdedPostsIds))
    }
    
}
