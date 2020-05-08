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
    let dateFormater: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "Ru_ru")
        df.dateFormat = "d MMM 'в' HH:mm"
        return df
    }()
    
    func presentData(response: VKNewsFeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsFeed(feedResponse: let feedResponse):
            let cells = feedResponse.items.map({ feedItem in
                cellViewModel(from: feedItem, profiles: feedResponse.profiles, groups: feedResponse.groups)
            })
            
            let feedViewModel = FeedViewModel.init(cells: cells)
            
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: VKFeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        let profile = self.profile(from: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormater.string(from: date)
        return FeedViewModel.Cell.init(iconUrl: profile.photo,
                                name: profile.name,
                                date: dateTitle,
                                likes: feedItem.likes?.count.description ?? "0",
                                views: feedItem.views?.count.description ?? "0",
                                shares: feedItem.reposts?.count.description ?? "0",
                                comments: feedItem.comments?.count.description ?? "0",
                                post: feedItem.text)
    }
    
    private func profile(from sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first {[weak self] (myProfileRepresentable) in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
    
}
