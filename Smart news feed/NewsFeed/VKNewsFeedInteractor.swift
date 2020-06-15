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

    
    func makeRequest(request: VKNewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = VKNewsFeedService()
        }
        switch request {
        case .getNewsFeed:
            service?.getFeed(completion: { [weak self] (revealedPostIds, feed) in
                self?.presenter?.presentData(response: .presentNewsFeed(feedResponse: feed, revealdedPostIds: revealedPostIds))
            })
        case .revealCellFromPostId(postId: let postId):
            service?.revealedPostIds(forPostIds: postId, completion: { [weak self] (revealedPostIds, feed) in
                self?.presenter?.presentData(response: .presentNewsFeed(feedResponse: feed, revealdedPostIds: revealedPostIds))
            })
        case .getUserPhotoUrl:
            service?.getUser(completion: { [weak self] (user) in
                self?.presenter?.presentData(response: .presentUserPhoto(photoUrl: (user?.photo100)!))
            })
        case .getNewsBatch:
            print("123")
            service?.getNewsBatch(completion: { (revealedPostIds, feed) in
                self.presenter?.presentData(response: .presentNewsFeed(feedResponse: feed, revealdedPostIds: revealedPostIds))
            })
        }
    }
}
