//
//  ArtDetailViewController.swift
//  ArtApp
//
//  Created by Виталик Молоков on 14.02.2024.
//

// ArtistDetailViewController.swift

import UIKit

class ArtDetailViewController: UIViewController {
    
    //MARK: - Properties
    var artist: Artist?
    var selectedWork: Work?
    
    //MARK: - UI Components
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var bioLabel = UILabel()
    private lazy var artworksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(ArtworkCollectionViewCell.self, 
                                        forCellWithReuseIdentifier: "ArtworkCell")
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        configureViews()
    }
    
    //MARK: - Setups
    private func setupHierarchy() {
        view.addSubview(scrollView)
        view.backgroundColor = .black
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(bioLabel)
        contentView.addSubview(artworksCollectionView)
        
        artworksCollectionView.backgroundColor = .clear
        artworksCollectionView.delegate = self
        artworksCollectionView.dataSource = self
        artworksCollectionView.register(ArtworkCollectionViewCell.self, 
                                        forCellWithReuseIdentifier: "ArtworkCell")
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
        artworksCollectionView.snp.makeConstraints { make in
            make.top.equalTo(bioLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(200)
            make.bottom.equalToSuperview()
        }
        
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.right.equalTo(view).inset(20)
        }
    }
    
    private func configureViews() {
        guard let artist = artist else { return }
        bioLabel.text = artist.bio
        bioLabel.textColor = .white
        bioLabel.numberOfLines = 0
    }
}

