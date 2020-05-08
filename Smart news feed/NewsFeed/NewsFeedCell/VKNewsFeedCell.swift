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
    var text : String? { get }
    var likes : String? { get }
    var views : String? { get }
    var shares : String? { get }
    var comments : String? { get }
}

class VKNewsFeedCell: UITableViewCell {
    
    static let reuseId = "vkCell"
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var sharesLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(viewModel: VKFeedCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.dateLabel.text = viewModel.date
        self.sharesLabel.text = viewModel.shares
        self.likesLabel.text = viewModel.likes
        self.commentsLabel.text = viewModel.comments
        self.viewsLabel.text = viewModel.views
        
    }
    
}
