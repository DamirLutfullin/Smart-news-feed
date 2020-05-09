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
    

    static let bottomViewHeight = CGFloat(53)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let constantHeight = Constants.topViewHeight + Constants.bottomViewHeight + 8 + 8 + 8
}

struct Sizes: FeedCellSizes {
    var bottonView: CGRect
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
        let width = cardViewWidth - Constants.postLabelInsest.left - Constants.postLabelInsest.left
        
        //MARK: Работа с пост лейбл фрейм
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsest.left, y: Constants.postLabelInsest.top), size: CGSize.zero)
        if let text = postText, !text.isEmpty {
            let height = text.height(width: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        //MARK: Работа с фото
        var photoHeight: CGFloat = 0
        var photoWidth: CGFloat = 0
        var imageFrame = CGRect.zero
        if let photo = photoAttachment {
            photoHeight = CGFloat(photo.height)
            photoWidth = CGFloat(photo.width)
            imageFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsest.left, y: postLabelFrame.origin.y + 8 + postLabelFrame.height), size: CGSize(width: width, height: photoHeight / (photoWidth / width)))
        }
        
        //MARK: ставим бот вью на место
        let bottomOriginY: CGFloat = {
            if photoHeight != 0 {
                return imageFrame.origin.y + CGFloat(8) + imageFrame.height
            } else {
                return postLabelFrame.origin.y + postLabelFrame.height + 8
            }
        }()
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: Constants.cardInsest.left, y: bottomOriginY), size: CGSize(width: width, height: 53))
        
        return  Sizes(bottonView: bottomViewFrame,
                      postLabelFrame: postLabelFrame,
                      AttachmentFrame: imageFrame,
                      totalHeight:  bottomViewFrame.origin.y + 53 + 8)
    }
}
