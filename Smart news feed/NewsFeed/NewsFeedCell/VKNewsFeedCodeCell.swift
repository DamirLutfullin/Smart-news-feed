//
//  VKNewsFeedCodeCell.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 10.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseId = "newsFeedCodeCell"
    
    //MARK: first layer
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false // чтобы разрешить компилятору закреплять данный вью на экране
        view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        return view
    }()
    // MARK: second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false // чтобы разрешить компилятору закреплять данный вью на экране
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        return view
    }()
    let postsLabel: UILabel = {
        let label = UILabel()
       // label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.postLabelFont
        label.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        label.textColor = #colorLiteral(red: 0.2366705537, green: 0.2514012158, blue: 0.2652153969, alpha: 1)
        return label
    }()
    let postImageView: WebImageView = {
        let imageView = WebImageView()
    //    imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return imageView
    }()
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
     //   view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: third layer
    // to topView
    let iconImage: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.backgroundColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    //to bottom view
    let likesImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "like")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let commentsImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "comment")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let repostImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "share")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let viewsImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "eye")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let repostLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    //Set func
    func set(viewModel: VKFeedCellViewModel) {
//        self.iconImageView.set(imageURL: viewModel.iconUrl)
//        self.nameLabel.text = viewModel.name
//        self.dateLabel.text = viewModel.date
//        self.sharesLabel.text = viewModel.shares
//        self.likesLabel.text = viewModel.likes
//        self.commentsLabel.text = viewModel.comments
//        self.viewsLabel.text = viewModel.views
//        self.postsLabel.text = viewModel.post
        
        postsLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.AttachmentFrame
        bottomView.frame = viewModel.sizes.bottonViewFrame

        if let photoAttachment = viewModel.photoAttachment{
            postImageView.isHidden = false
            //postImageView.set(imageURL: photoAttachment.photoUrlString)
        } else {
            postImageView.isHidden = true
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.9369474649, green: 0.3679848909, blue: 0.426604867, alpha: 1)
        
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayer()
    
    }
    
    // overlay card view
    private func overlayFirstLayer() {
        addSubview(cardView)
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    // overlay second view
    private func overlaySecondLayer() {
        // top view constreints
        cardView.addSubview(topView)
        topView.anchor(top: cardView.topAnchor,
                       leading: cardView.leadingAnchor,
                       bottom: nil,
                       trailing: cardView.trailingAnchor,
                       padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
                       size: CGSize(width: 0, height: Constants.topViewHeight))

        cardView.addSubview(postsLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
    }
    
    // overlay third view
    private func overlayThirdLayer() {
        //to top view
        topView.addSubview(iconImage)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        iconImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImage.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        iconImage.widthAnchor.constraint(equalTo: iconImage.heightAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 4).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.4).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.3).isActive = true
        
        //to bottom view
        

    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
