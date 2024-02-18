//
//  ArtDetailViewController+Ext.swift
//  ArtApp
//
//  Created by Виталик Молоков on 18.02.2024.
//

import UIKit

extension ArtDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artist?.works.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtworkCell", for: indexPath) as? ArtworkCollectionViewCell else {
            fatalError("Unable to dequeue ArtworkCollectionViewCell")
        }
        if let artwork = artist?.works[indexPath.item] {
            cell.configure(with: artwork)
        }
        return cell
    }
}

extension ArtDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout, 
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }
}

extension ArtDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, 
                        didSelectItemAt indexPath: IndexPath) {
        guard let artwork = artist?.works[indexPath.item],
              let image = UIImage(named: artwork.image) else { return }
        
        let fullscreenVC = FullscreenImageViewController()
        fullscreenVC.image = image
        fullscreenVC.modalPresentationStyle = .fullScreen
        fullscreenVC.modalTransitionStyle = .crossDissolve
        present(fullscreenVC, animated: true)
    }
}

