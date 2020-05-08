//
//  VKNewsFeedPresenter.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 07.05.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol VKNewsFeedPresentationLogic {
    func presentData(response: VKNewsFeed.Model.Response.ResponseType)
}

class VKNewsFeedPresenter: VKNewsFeedPresentationLogic {
    weak var viewController: VKNewsFeedDisplayLogic?
    
    func presentData(response: VKNewsFeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsFeed(feedResponse: let feedResponse):
            let cells = feedResponse.items.map({ feedItem in
                cellViewModel(from: feedItem)
            })
            
            
            let feedViewModel = FeedViewModel.init(cells: cells)
            
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: VKFeedItem) -> FeedViewModel.Cell {
        FeedViewModel.Cell.init(iconUrl: "String",
                                name: "feedItem",
                                date: "feedItem",
                                likes: feedItem.likes?.count.description ?? "0",
                                views: feedItem.views?.count.description ?? "0",
                                shares: feedItem.reposts?.count.description ?? "0",
                                comments: feedItem.comments?.count.description ?? "0",
                                post: feedItem.text)
    }
    
}
