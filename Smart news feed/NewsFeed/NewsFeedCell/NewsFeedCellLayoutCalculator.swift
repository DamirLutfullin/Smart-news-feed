//
//  NewsFeedCellLayoutCalculator.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 09.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol FeedCellLayoutCaculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizePost: Bool) -> FeedCellSizes
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8)
    static let topViewHeight: CGFloat = 60
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 17)
    static let bottomViewHeight: CGFloat = 44
    static let maxLines: CGFloat = 8
    static let showingLines: CGFloat = 6
    static let maxHeight = Constants.postLabelFont.lineHeight * Constants.maxLines
    static let showingHeight = Constants.postLabelFont.lineHeight * Constants.showingLines
}

struct Sizes: FeedCellSizes {
    var bottonViewFrame: CGRect
    var postLabelFrame: CGRect
    var AttachmentFrame: CGRect
    var showFullTextButtonFrame: CGRect
    var totalHeight: CGFloat
}

final class FeedCellLayoutCaculator: FeedCellLayoutCaculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizePost: Bool) -> FeedCellSizes {
        
        var showButton: Bool = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.left
        
        //MARK: Работа с пост лейбл фрейм
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
    
        if let text = postText, !text.isEmpty {
            var height = text.height(width: width, font: Constants.postLabelFont)
            if !isFullSizePost && height > Constants.maxHeight {
                height = Constants.showingHeight
                showButton = true
            }
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: работа с кнопкой показать весь текст
        var showFullTextButtonFrame: CGRect = .zero
        if showButton {
            showFullTextButtonFrame = CGRect(x: 8, y: postLabelFrame.maxY + 8, width: 170, height: 30)
        } else {
            showFullTextButtonFrame = .zero
        }
        
        //MARK: Работа с фото
        let attachmentTop = postLabelFrame.size == .zero ? Constants.postLabelInsets.top : max(postLabelFrame.maxY, showFullTextButtonFrame.maxY) + Constants.postLabelInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: .zero)
        
        if let photo = photoAttachments.first {
            attachmentFrame.size = CGSize(width: cardViewWidth, height: CGFloat(photo.height) / (CGFloat(photo.width) / CGFloat(cardViewWidth)))
        }
        
        //MARK: ставим бот вью на место
        let bottomOriginY: CGFloat = max(attachmentFrame.maxY, postLabelFrame.maxY, showFullTextButtonFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomOriginY), size: CGSize(width: cardViewWidth, height: 53))
        
        //MARK: работа с финальной высотой
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom + Constants.cardInsets.top
        
        return  Sizes(bottonViewFrame: bottomViewFrame,
                      postLabelFrame: postLabelFrame,
                      AttachmentFrame: attachmentFrame,
                      showFullTextButtonFrame: showFullTextButtonFrame,
                      totalHeight:  totalHeight)
    }
}
