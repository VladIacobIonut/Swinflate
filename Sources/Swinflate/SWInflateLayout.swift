//
//  SWInflateLayout.swift
//  Swinflate
//
//  Created by Vlad on 12/17/18.
//  Copyright © 2018 Vlad Iacob. All rights reserved.
//

import UIKit

public final class SWInflateLayout: UICollectionViewFlowLayout {
    // MARK: - Properties
    
    public var isPagingEnabled = true
    public var leftContentOffset: CGFloat = 0
    private var firstSetupDone = false
    private var cellWidth: CGFloat = 0
    private var contentSpacing: CGFloat = 0
    
    // MARK: - Override
    
    override public func prepare() {
        super.prepare()
        
        guard !firstSetupDone else {
            return
        }
        
        scrollDirection = .horizontal
        firstSetupDone = true
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // If the property `isPagingEnabled` is set to false, we don't enable paging and thus return the current contentoffset.
        guard isPagingEnabled else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }
        
        // Page width used for estimating and calculating paging
        let pageWidth = cellWidth + self.minimumInteritemSpacing
        
        // Make an estimation of the current page position.
        let approximatePage = self.collectionView!.contentOffset.x / pageWidth
        
        // Determine the current page based on velocity.
        let currentPage = (velocity.x < 0.0) ? floor(approximatePage) : ceil(approximatePage)
        
        // Create custom flickVelocity.
        let flickVelocity = velocity.x * 0.4
        
        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)
        
        // Calculate newHorizontalOffset
        let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) - self.collectionView!.contentInset.left
        
        return CGPoint(x: newHorizontalOffset - (2 * leftContentOffset), y: proposedContentOffset.x)
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let items = NSMutableArray (array: super.layoutAttributesForElements(in: rect)!, copyItems: true)
        
        guard let firstCellAttribute = items.firstObject as? UICollectionViewLayoutAttributes else {
            return nil
        }

        cellWidth = firstCellAttribute.size.width
        
        guard let collectionViewBounds  = collectionView?.bounds else {
            return nil
        }
        
        contentSpacing = (collectionViewBounds.width - cellWidth) / 2 - leftContentOffset
        collectionView?.contentInset = UIEdgeInsets(top: collectionView?.contentInset.top ?? 0, left: contentSpacing - leftContentOffset, bottom: collectionView?.contentInset.bottom ?? 0 , right: 15)
        
        items.enumerateObjects { (object, index, stop) in
            let attribute = object as! UICollectionViewLayoutAttributes
            self.cellWidth = attribute.size.width
            self.updateCellAttributes(attribute: attribute)
        }
        
        return items as? [UICollectionViewLayoutAttributes]
    }
    
    // MARK: - Private functions
    
    private func updateCellAttributes(attribute: UICollectionViewLayoutAttributes) {
        var finalX: CGFloat = attribute.frame.midX - (collectionView?.contentOffset.x)!
        let centerX = attribute.frame.midX - (collectionView?.contentOffset.x)!
        if centerX < collectionView!.frame.midX - contentSpacing {
            finalX = max(centerX, collectionView!.frame.minX)
        }
        else if centerX > collectionView!.frame.midX + contentSpacing {
            finalX = min(centerX, collectionView!.frame.maxX)
        }
        
        let deltaY = abs(finalX - collectionView!.frame.midX) / attribute.frame.width
        let scale = 1 - deltaY * 0.2
        let alpha = 1 - deltaY
        
        attribute.alpha = alpha
        attribute.transform = CGAffineTransform(scaleX: 1, y: scale)
    }
}

