//
//  VKFeedResponse.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 07.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

struct VKFeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [VKFeedItem]
}

struct VKFeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let date: Double
    let text: String?
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
}
