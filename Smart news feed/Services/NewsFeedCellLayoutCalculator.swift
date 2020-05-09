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

struct Constants {
    static let cardInsest = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight = CGFloat(52)
    static let postLabelInsest = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
}

struct Sizes: FeedCellSizes {
    var buttonViewL: CGRect
    var postLabelFrame: CGRect
    var AttachmentFrame: CGRect
    var totalHeight: CGFloat
}

final class FeedCellLayoutCaculator: FeedCellLayoutCaculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constants.cardInsest.left - Constants.cardInsest.right
        
        //MARK: Работа с пост лейбл фрейм
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsest.left, y: Constants.postLabelInsest.top), size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsest.left - Constants.postLabelInsest.left
            let height = text.height(width: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        return  Sizes(buttonViewL: CGRect.zero,
                      postLabelFrame: postLabelFrame,
                      AttachmentFrame: CGRect.zero,
                      totalHeight: 300 + postLabelFrame.height)
    }
}
