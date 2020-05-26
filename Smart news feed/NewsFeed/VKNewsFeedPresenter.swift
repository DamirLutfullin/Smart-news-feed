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
    
    var cellLayoutCalculator: FeedCellLayoutCaculatorProtocol = FeedCellLayoutCaculator()
    
    let dateFormater: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "Ru_ru")
        df.dateFormat = "d MMM 'в' HH:mm"
        return df
    }()
    
    func presentData(response: VKNewsFeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsFeed(let feedResponse, let revealdedPostsIds):
            let cells = feedResponse.items.map({ feedItem in
                cellViewModel(from: feedItem, profiles: feedResponse.profiles, groups: feedResponse.groups, revealdedPostIds: revealdedPostsIds)
            })
            let feedViewModel = FeedViewModel.init(cells: cells)
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        case .presentUserPhoto(photoUrl: let photoUrl):
            print(".presentUserPhoto photo url is " + photoUrl)
            viewController?.displayData(viewModel: VKNewsFeed.Model.ViewModel.ViewModelData.displayUsersPhoto(photoUrl: photoUrl))
        }
    }
    
    private func cellViewModel(from feedItem: VKFeedItem, profiles: [Profile], groups: [Group], revealdedPostIds: [Int]) -> FeedViewModel.Cell {
        let profile = self.profile(from: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormater.string(from: date)
        let isfullSizePost = revealdedPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizePost: isfullSizePost)
        
        return FeedViewModel.Cell.init(photoAttachments: photoAttachments,
                                       postId: feedItem.postId,
                                       iconUrl: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       likes: feedItem.likes?.count.description ?? "0",
                                       views: feedItem.views?.count.description ?? "0",
                                       shares: feedItem.reposts?.count.description ?? "0",
                                       comments: feedItem.comments?.count.description ?? "0",
                                       post: feedItem.text,
                                       sizes: sizes)
    }
    
    private func profile(from sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first {myProfileRepresentable in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
    
   
    private func photoAttachments(feedItem: VKFeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let photos = feedItem.attachments else { return [] }
        return photos.compactMap( { (attachments) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo  = attachments.photo else { return nil}
            return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.srcBig, width: photo.width, height: photo.height)
        })
        
    }
    
}
