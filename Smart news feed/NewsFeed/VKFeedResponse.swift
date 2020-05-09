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
    var profiles: [Profile]
    var groups: [Group]
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: Decodable, ProfileRepresentable {
    
    var id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String { return firstName + " " + lastName}
    var photo: String { return photo100 }
}

struct Group: Decodable, ProfileRepresentable {
    let id: Int
    let name: String
    let photo100: String
    
    var photo: String { return photo100 }
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
    let attachments: [Attachment]?
}

struct CountableItem: Decodable {
    let count: Int
}

struct Attachment: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    
    let sizes: [PhotoSize]
    
    var height: Int {
        return GetPropperSize().height
    }
    var width: Int {
        return GetPropperSize().width
    }
    var srcBig: String {
        return GetPropperSize().url
    }
    
    private func GetPropperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: {$0.type == "x"}) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
