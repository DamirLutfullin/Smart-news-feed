//
//  GalleryCollectionView.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 21.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class GalleryCollectionView: UICollectionView {
    
    var photoArray = [FeedCellPhotoAttachmentViewModel]()

    init() {
        let layout = ItemLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        delegate = self
        dataSource = self
        layout.delegate = self
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.description())
    }
    
    func set( photoAttachments: [FeedCellPhotoAttachmentViewModel]) {
        print("gcv got photo")
        self.photoArray = photoAttachments
        reloadData()
        print(photoArray.count)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GalleryCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, GalleryCollectionViewCustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt indexPath: IndexPath")
        let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.description(), for: indexPath) as! GalleryCollectionViewCell
        if let photoUrl = photoArray[indexPath.row].photoUrlString {
            print("gor photo url")
            cell.set(url: photoUrl) }
        else {
            print("cant get photo url")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> CGSize {
        print(#function)
        let photo = photoArray[indexPath.item]
        return CGSize(width: photo.width, height: photo.height)
    }

}
