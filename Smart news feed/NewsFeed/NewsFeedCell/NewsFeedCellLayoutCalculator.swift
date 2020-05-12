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
    static let cardInsets = UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8)
    static let topViewHeight: CGFloat = 60
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
}

struct Sizes: FeedCellSizes {
    var bottonViewFrame: CGRect
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
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.left
        
        //MARK: Работа с пост лейбл фрейм
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        if let text = postText, !text.isEmpty {
            let height = text.height(width: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: Работа с фото
        let attachmentTop = postLabelFrame.size == .zero ? Constants.postLabelInsets.top : postLabelFrame.maxY + Constants.postLabelInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: .zero)
        
        if let photo = photoAttachment {
            attachmentFrame.size = CGSize(width: cardViewWidth, height: CGFloat(photo.height) / (CGFloat(photo.width) / CGFloat(cardViewWidth)))
        }
        
        //MARK: ставим бот вью на место
        let bottomOriginY: CGFloat = max(attachmentFrame.maxY, postLabelFrame.maxY )
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomOriginY), size: CGSize(width: cardViewWidth, height: 53))
        
        //MARK: работа с финальной высотой
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom + Constants.cardInsets.top
        
        return  Sizes(bottonViewFrame: bottomViewFrame,
                      postLabelFrame: postLabelFrame,
                      AttachmentFrame: attachmentFrame,
                      totalHeight:  totalHeight)
    }
}
