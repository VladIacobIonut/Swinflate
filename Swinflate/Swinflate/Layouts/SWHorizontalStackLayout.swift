//
//  SWHorizontalStackLayout.swift
//  Swinflate
//
//  Created by Vlad on 12/20/18.
//  Copyright © 2018 Vlad Iacob. All rights reserved.
//

import UIKit

final class SWHorizontalStackLayout: UICollectionViewFlowLayout {
    // MARK: - Properties
    
    var hasStackEffect: Bool = false
    var isPagingEnabled: Bool = true
    private var firstSetupDone: Bool = false
    private var cellWidth: CGFloat = 0
    private let scaleRatio: CGFloat = 0.05
    
    // MARK: - Override
    
    override func prepare() {
        super.prepare()
        
        guard firstSetupDone else {
            setup()
            firstSetupDone = true
            return
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // If the property `isPagingEnabled` is set to false, we don't enable paging and thus return the current contentoffset.
        guard isPagingEnabled else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }
        
        // Page width used for estimating and calculating paging.
        let pageWidth = cellWidth + self.minimumInteritemSpacing
        
        // Make an estimation of the current page position.
        let approximatePage = self.collectionView!.contentOffset.x / pageWidth
        
        // Determine the current page based on velocity.
        let currentPage = (velocity.x < 0.0) ? floor(approximatePage) : ceil(approximatePage)
        
        // Create custom flickVelocity.
        let flickVelocity = velocity.x * 0.4
        
        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)
        
        // Calculate newVerticalOffset.
        let newVerticalOffset = ((currentPage + flickedPages) * pageWidth) - self.collectionView!.contentInset.left
        
        return CGPoint(x: newVerticalOffset, y: proposedContentOffset.y)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let allAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        guard let firstAttribute = allAttributes.first else { return nil }
        
        cellWidth = firstAttribute.size.width
        
        for attribute in allAttributes {
            self.updateAttribute(attribute)
        }
        
        return allAttributes
    }
    
    // MARK: - Private Functions
    
    private func setup() {
        scrollDirection = .horizontal
        collectionView!.decelerationRate = UIScrollView.DecelerationRate.normal
    }
    
    private func updateAttribute(_ attributes: UICollectionViewLayoutAttributes) {
        guard let collectionView = collectionView else { return }
        let minX = collectionView.bounds.minX + collectionView.contentInset.left
        let maxX = attributes.frame.origin.x
        
        let finalX = max(minX, maxX)
        var origin = attributes.frame.origin
        let deltaY = (finalX - origin.x) / attributes.frame.width
        
        let scale = 1 - deltaY * scaleRatio
        let translation = CGFloat((attributes.zIndex + 1) * 10)
        
        var t = CGAffineTransform.identity
        t = t.scaledBy(x: 1, y: scale)
        
        if hasStackEffect {
            t = t.translatedBy(x: -(translation + deltaY * translation), y: 0)
        }
        attributes.alpha = 1 - deltaY * 0.6
        attributes.transform = t
        
        origin.x = finalX
        attributes.frame = CGRect(origin: origin, size: attributes.frame.size)
        attributes.zIndex = attributes.indexPath.row
    }
}
