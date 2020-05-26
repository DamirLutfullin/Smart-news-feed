
//
//  TitleView.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 26.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class TitleView: UIView {
    
    let textField = MyTextField()
    
    let myAvatarView: WebImageView = {
        let view = WebImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        view.contentMode = .scaleAspectFill
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(myAvatarView)
        addSubview(textField)
        
        createConstraints()
    }
    
    func createConstraints() {
        // my Avater Constraints
        myAvatarView.anchor(top: topAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: trailingAnchor,
                            padding: UIEdgeInsets(top: 4, left: 888, bottom: 888, right: 4))
        
        myAvatarView.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1).isActive = true
        myAvatarView.widthAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1).isActive = true
        
        //constaints for TF
        textField.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: myAvatarView.leadingAnchor,
                         padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
        
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myAvatarView.layer.masksToBounds = true
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
