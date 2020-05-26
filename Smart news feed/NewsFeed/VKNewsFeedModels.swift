//
//  VKNewsFeedModels.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 07.05.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

enum VKNewsFeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
                case revealCellFromPostId(postId: Int)
                case getUserPhotoUrl
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed (feedResponse: FeedResponse, revealdedPostIds: [Int])
                case presentUserPhoto (photoUrl: String)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
                case displayUsersPhoto(photoUrl: String)
            }
        }
    }
}

struct FeedViewModel {
    struct Cell: VKFeedCellViewModel {
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
        var postId: Int
        var iconUrl: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var views: String?
        var shares: String?
        var comments: String?
        var post: String?
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    
    let cells: [Cell]
}
