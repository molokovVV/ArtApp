//
//  ArtTableViewCell.swift
//  ArtApp
//
//  Created by Виталик Молоков on 14.02.2024.
//

// ArtistTableViewCell.swift

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Components
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setups
    private func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }
    
    func setupLayouts() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.contentView.snp.bottomMargin) // Обновлено для использования safe area
            make.height.equalTo(50)
        }
    }
    
    func configure(with artist: Artist) {
        nameLabel.text = artist.name
        imageView.image = UIImage(named: artist.image)
    }
}

