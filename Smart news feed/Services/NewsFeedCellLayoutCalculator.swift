//
//  NewsFeedCellLayoutCalculator.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 09.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol FeedCellLayoutCaculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    
    var AttachmentFrame: CGRect
    
}

final class FeedCellLayoutCaculator: FeedCellLayoutCaculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        return Sizes(postLabelFrame: CGRect.zero, AttachmentFrame: CGRect.zero)
    }
    
}
