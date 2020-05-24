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
    
    weak var delegate: GalleryCollectionViewCustomLayoutDelegate?
    
    var contentWidth: CGFloat = 0
    var contentHeight: CGFloat = 0
    
    var photoAttributes = [UICollectionViewLayoutAttributes]()
    
    //возвращает размер всего нашего вью
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // тут все вычисляем
    // по сути надо вычислить аттрибуты и размер всего вью
    override func prepare() {
        super.prepare()
        var photosSizes = [CGSize]()
        var minRotationPhotoSize: CGSize = .zero
        guard let collectionView = collectionView else {
            print("cant get collection view in ItemLayout")
            return
        }
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            guard let sizeOfPhoto = delegate?.collectionView(collectionView, atIndexPath: indexPath) else {
                print("cant get photoSize in ItemLayout")
                return }
            photosSizes.append(sizeOfPhoto)
        }
        
       minRotationPhotoSize = photosSizes.min { (first, second) -> Bool in
            (first.height / first.width ) < (second.height / second.width)
        } ?? CGSize.zero
        
        let proportion = UIScreen.main.bounds.width / minRotationPhotoSize.width
        contentHeight = minRotationPhotoSize.height * proportion
        
        for (index, photoSize) in photosSizes.enumerated() {
            contentWidth += photoSize.width
            let attribute = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: index, section: 0))
            attribute.frame = CGRect(x: contentWidth - photoSize.width, y: 0, width: photoSize.width, height: contentHeight)
        }
        
    }
    
    
    // возвращает аттрибуты элементов, которые видно на экрана
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var intersectsAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in photoAttributes {
            if attributes.frame.intersects(rect) {
                intersectsAttributes.append(attributes)
            }
        }
        return intersectsAttributes
        
    }
    
    // возвращает аттрибуты отдельного элемента
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return photoAttributes[indexPath.item]
    }

}
