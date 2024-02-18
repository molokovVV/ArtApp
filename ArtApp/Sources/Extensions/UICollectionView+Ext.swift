//
//  UICollectionView+Ext.swift
//  ArtApp
//
//  Created by Виталик Молоков on 18.02.2024.
//

import UIKit

extension UICollectionView {
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UITapGestureRecognizer {
            let point = gestureRecognizer.location(in: self)
            if let indexPath = indexPathForItem(at: point) {
                if let cell = cellForItem(at: indexPath) {
                    return cell.isUserInteractionEnabled
                }
            }
        }
        return true
    }
}
