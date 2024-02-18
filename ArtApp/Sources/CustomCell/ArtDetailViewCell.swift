//
//  ArtDetailViewCell.swift
//  ArtApp
//
//  Created by Виталик Молоков on 15.02.2024.
//

import UIKit

class ArtworkCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Components
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setups
    private func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .black
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(titleLabel.snp.top).offset(-10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
    }
    
    func configure(with artwork: Work) {
        titleLabel.text = artwork.title
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: artwork.image)
    }
}



