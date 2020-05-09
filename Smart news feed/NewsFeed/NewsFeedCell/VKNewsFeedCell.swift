//
//  VKNewsFeedCell.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 08.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol VKFeedCellViewModel {
    var iconUrl: String { get }
    var name : String { get }
    var date : String { get }
    var likes : String? { get }
    var views : String? { get }
    var shares : String? { get }
    var comments : String? { get }
    var post : String? { get }
    var photoAttachment: FeedCellPhotoAttachmentViewModel? { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var AttachmentFrame: CGRect { get }
    var bottonView: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? {get}
    var width: Int {get}
    var height: Int {get}
}

class VKNewsFeedCell: UITableViewCell {
    
    static let reuseId = "vkCell"
    @IBOutlet var iconImageView: WebImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var postsLabel: UILabel!
    @IBOutlet var sharesLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!
    @IBOutlet var postImageView: WebImageView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var buttonView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        backgroundColor = .clear
        selectionStyle = .none
    }
 
    func set(viewModel: VKFeedCellViewModel) {
        self.iconImageView.set(imageURL: viewModel.iconUrl)
        self.nameLabel.text = viewModel.name
        self.dateLabel.text = viewModel.date
        self.sharesLabel.text = viewModel.shares
        self.likesLabel.text = viewModel.likes
        self.commentsLabel.text = viewModel.comments
        self.viewsLabel.text = viewModel.views
        self.postsLabel.text = viewModel.post
        
        postsLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.AttachmentFrame
        buttonView.frame = viewModel.sizes.bottonView

        if let photoAttachment = viewModel.photoAttachment{
            postImageView.isHidden = false
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.layer.cornerRadius = 20
            //postImageView.image?.
        } else {
            postImageView.isHidden = true
        }
    }
}
