//
//  ItemLayout.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 21.05.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol GalleryCollectionViewCustomLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> CGSize
}


// тут нам нужно вернуть макет для элементов
class ItemLayout: UICollectionViewLayout {
    
    weak var delegate: GalleryCollectionViewCustomLayoutDelegate!
    
    static var numbersOfRows = 1
    fileprivate var cellPadding: CGFloat = 8
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contentWidth: CGFloat = 0
    
    // константа
    fileprivate var contentHeight: CGFloat {
        
        guard let collectionView = collectionView else { return 0 }

        let insets =  collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        contentWidth = 0
        cache = []
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        
        var photos = [CGSize]()
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, atIndexPath: indexPath)
            photos.append(photoSize)
        }
        
        if photos.count > 4 {
            ItemLayout.numbersOfRows = 2
        } else {
            ItemLayout.numbersOfRows = 1
        }
        
        let superviewWidth = collectionView.frame.width
        
        guard var rowHeight = ItemLayout.rowHeightCounter(superviewWidth: superviewWidth, photosArray: photos) else { return }
        
        rowHeight = rowHeight / CGFloat(ItemLayout.numbersOfRows)
        
        let photosRatios = photos.map { $0.height / $0.width }
        
        var yOffset = [CGFloat]()
        for row in 0 ..< ItemLayout.numbersOfRows {
            yOffset.append(CGFloat(row) * rowHeight)
        }
        
        var xOffset = [CGFloat](repeating: 0, count: ItemLayout.numbersOfRows)
        
        var row = 0
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let ratio = photosRatios[indexPath.row]
            let width = (rowHeight / ratio)
            let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            cache.append(attribute)
            
            contentWidth = max(contentWidth, frame.maxX)
            xOffset[row] = xOffset[row] + width
            row = row < (ItemLayout.numbersOfRows - 1) ? (row + 1) : 0
        }
        
    }
    
    static func rowHeightCounter(superviewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
        var rowHeight: CGFloat
        
        let photoWithMinRatio = photosArray.min { (first, second) -> Bool in
            (first.height / first.width) < (second.height / second.width)
        }
        
        guard let myPhotoWithMinRatio = photoWithMinRatio else { return nil }
        
        let difference = superviewWidth / myPhotoWithMinRatio.width
        
        rowHeight = myPhotoWithMinRatio.height * difference
        
        rowHeight = rowHeight * CGFloat(ItemLayout.numbersOfRows)
        return rowHeight
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attatibute in cache {
            if attatibute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attatibute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
}
