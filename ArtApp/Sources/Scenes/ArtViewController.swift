//
//  ViewController.swift
//  ArtApp
//
//  Created by Виталик Молоков on 14.02.2024.
//

// ViewController.swift

import UIKit

class ArtViewController: UIViewController {
    
    //MARK: - Properties
    var artists: [Artist] = []
    
    
    //MARK: - UI Components
    lazy var searchController: UISearchController = {
        let searchResultsController = SearchResultsViewController()
        let searchController = UISearchController(searchResultsController: searchResultsController)
        return searchController
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, 
                                 height: UIScreen.main.bounds.height)
        
        let collectionView = UICollectionView(frame: .zero, 
                                              collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        collectionView.register(ArtistCollectionViewCell.self, 
                                forCellWithReuseIdentifier: "ArtistCell")
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        loadArtists()
        setupCollectionView()
        addSearchButtonToNavigationBar()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.searchController = nil
    }
    
    //MARK: - Setups
    private func setupView() {
        
    }
    
    private func setupHierarchy() {
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadArtists() {
        if let loadedArtists = ArtistsDataLoader.loadJson(filename: "artists") {
            self.artists = loadedArtists
            self.collectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    
    private func addSearchButtonToNavigationBar() {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), 
                                           style: .plain, 
                                           target: self, 
                                           action: #selector(presentSearchController))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, 
                                                                 action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Actions
    @objc private func presentSearchController() {
        setupSearch()
        searchController.searchBar.becomeFirstResponder()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.isActive = true
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
