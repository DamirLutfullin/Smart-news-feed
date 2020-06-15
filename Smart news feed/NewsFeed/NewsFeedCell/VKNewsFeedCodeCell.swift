//
//  VKNewsFeedCodeCell.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 10.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol ShowFullTextButtonDelegate: class {
    func revealText(cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {

    static let reuseId = "newsFeedCodeCell"
    
    weak var showFullTextDelegate: ShowFullTextButtonDelegate? = nil
    
    
    //MARK: first layer
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false // чтобы разрешить компилятору закреплять данный вью на экране
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.cornerRadius = 15
        return view
    }()
    
    
    // MARK: second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false // чтобы разрешить компилятору закреплять данный вью на экране
        return view
    }()
    
    let repostTextView: UITextView = {
        let textView = UITextView()
        textView.font = Constants.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.dataDetectorTypes = .all
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets.init(top: 0, left: 0, bottom: -padding, right: -padding)
        return textView
    }()
    
    let showFullTextButton: UIButton = {
        let button = UIButton()
        button.setTitle("показать полностью...", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(#colorLiteral(red: 0.1138304099, green: 0.5649178028, blue: 0.9794030786, alpha: 1), for: .normal)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        //    imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3098039216, blue: 0.3294117647, alpha: 1)
        return imageView
    }()
    
    let galleryCollectionView =  GalleryCollectionView()
    
    let bottomView: UIView = {
        let view = UIView()
        //   view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: third layer
    // to topView
    let iconImage: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        label.numberOfLines = 0
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
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
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repostLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    
    //MARK: Set func
    func set(viewModel: VKFeedCellViewModel) {
        if var view = viewModel.views, Double(view)! > 1000 {
           let viewsDouble = Double(view)! / 1000
            view = String(format: "%.1f", viewsDouble) + "K"
            self.viewsLabel.text = view
        } else {
            self.viewsLabel.text = viewModel.views
        }
        self.iconImage.set(imageURL: viewModel.iconUrl)
        self.nameLabel.text = viewModel.name
        self.dateLabel.text = viewModel.date
        self.repostLabel.text = viewModel.shares
        self.likesLabel.text = viewModel.likes
        self.commentsLabel.text = viewModel.comments
        self.repostTextView.text = viewModel.post
        
        repostTextView.frame = viewModel.sizes.postLabelFrame
        bottomView.frame = viewModel.sizes.bottonViewFrame
        showFullTextButton.frame = viewModel.sizes.showFullTextButtonFrame
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.isHidden = false
            postImageView.frame = viewModel.sizes.AttachmentFrame
            galleryCollectionView.isHidden = true
            postImageView.set(imageURL: photoAttachment.photoUrlString)
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.AttachmentFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachments)
        } else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }

    //MARK: Init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        iconImage.layer.cornerRadius = Constants.topViewHeight / 2
        iconImage.clipsToBounds = true
        
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayer()
        
        showFullTextButton.addTarget(self, action: #selector(showFullTextButtonPressed), for: .touchUpInside)
    }
    
    @objc func showFullTextButtonPressed () {
        showFullTextDelegate?.revealText(cell: self)
    }

    override func prepareForReuse() {
        iconImage.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    //MARK: overlay card view
    private func overlayFirstLayer() {
        addSubview(cardView)
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    //MARK: overlay second view
    private func overlaySecondLayer() {
        // top view constreints
        cardView.addSubview(topView)
        topView.anchor(top: cardView.topAnchor,
                       leading: cardView.leadingAnchor,
                       bottom: nil,
                       trailing: cardView.trailingAnchor,
                       padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
                       size: CGSize(width: 0, height: Constants.topViewHeight))
        
        cardView.addSubview(repostTextView)
        cardView.addSubview(postImageView)
        cardView.addSubview(showFullTextButton)
        cardView.addSubview(bottomView)
        cardView.addSubview(galleryCollectionView)
    }
    
    
    //MARK: overlay third view
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
        bottomView.addSubview(likesImage)
        bottomView.addSubview(likesLabel)
        bottomView.addSubview(commentsImage)
        bottomView.addSubview(commentsLabel)
        bottomView.addSubview(repostImage)
        bottomView.addSubview(repostLabel)
        bottomView.addSubview(viewsImage)
        bottomView.addSubview(viewsLabel)
        
        likesImage.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        likesImage.heightAnchor.constraint(equalToConstant: likesImage.image?.size.height ?? 0).isActive = true
        likesImage.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16).isActive = true
        
        likesLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        likesLabel.widthAnchor.constraint(equalToConstant: 44).isActive = true
        likesLabel.leadingAnchor.constraint(equalTo: likesImage.trailingAnchor, constant: 4).isActive = true
        
        commentsImage.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        commentsImage.heightAnchor.constraint(equalToConstant: likesImage.image?.size.height ?? 0).isActive = true
        commentsImage.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 16).isActive = true
        
        commentsLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        commentsLabel.widthAnchor.constraint(equalToConstant: 44).isActive = true
        commentsLabel.leadingAnchor.constraint(equalTo: commentsImage.trailingAnchor, constant: 4).isActive = true
        commentsLabel.sizeToFit()
        
        repostImage.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        repostImage.heightAnchor.constraint(equalToConstant: likesImage.image?.size.height ?? 0).isActive = true
        repostImage.leadingAnchor.constraint(equalTo: commentsLabel.trailingAnchor, constant: 16).isActive = true
        
        repostLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        repostLabel.widthAnchor.constraint(equalToConstant: 44).isActive = true
        repostLabel.leadingAnchor.constraint(equalTo: repostImage.trailingAnchor, constant: 4).isActive = true
        
        viewsLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        viewsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 12).isActive = true
        viewsLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16).isActive = true
        
        viewsImage.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        viewsImage.heightAnchor.constraint(equalToConstant: likesImage.image?.size.height ?? 0).isActive = true
        viewsImage.trailingAnchor.constraint(equalTo: viewsLabel.leadingAnchor, constant: -4).isActive = true
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
