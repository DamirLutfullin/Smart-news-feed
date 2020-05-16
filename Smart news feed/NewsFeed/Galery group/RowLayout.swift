//
//  RowLayout.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 17.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation
import UIKit

protocol RowLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewLayout {
   
    weak var delegate: RowLayoutDelegate!
    
    fileprivate var numbersOfRows = 1
    fileprivate var cellPadding: CGFloat = 8
    
    fileprivate var cach = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contentWidth: CGFloat = 0
    //константа
    fileprivate var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - insets.left - insets.right
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cach.isEmpty == true, let collectionView = collectionView else { return }
        
        var photos = [CGSize]()
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        
        guard let rowHidht = self.heightRow(superviewWidth: collectionView.frame.width, photos: photos) else { return}
    }
    
    private func heightRow(superviewWidth: CGFloat, photos: [CGSize]) -> CGFloat? {
        guard let maxWidthPhoto = (photos.max{$0.width > $1.width}) else { return nil}
        let difference = superviewWidth / maxWidthPhoto.width
        return maxWidthPhoto.height * difference
    }
}
