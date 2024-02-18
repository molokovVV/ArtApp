//
//  ArtViewCOntroller+Ext.swift
//  ArtApp
//
//  Created by Виталик Молоков on 15.02.2024.
//

import UIKit

extension ArtViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for: indexPath) as? ArtistCollectionViewCell else {
            fatalError("Unable to dequeue ArtistCollectionViewCell.")
        }
        let artist = artists[indexPath.row]
        cell.configure(with: artist)
        return cell
    }
}

extension ArtViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, 
                        didSelectItemAt indexPath: IndexPath) {
        let artist = artists[indexPath.row]
        let detailVC = ArtDetailViewController()
        detailVC.artist = artist
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ArtViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout, 
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height - (collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom)
        return CGSize(width: width, height: height)
    }
}

extension ArtViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }

        var results: [SearchResult] = []
        let filteredArtists = artists.filter { $0.name.lowercased().contains(searchText) }
        results += filteredArtists.map { SearchResult.artist($0) }
        
        for artist in artists {
            let filteredWorks = artist.works.filter { $0.title.lowercased().contains(searchText) }
            results += filteredWorks.map { SearchResult.work(artist, $0) }
        }
        resultsController.searchResults = results
        resultsController.tableView.reloadData()
    }
}

extension ArtViewController: SearchResultsDelegate {
    func didSelectSearchResult(_ result: SearchResult) {
        switch result {
        case .artist(let artist):
            let detailVC = ArtDetailViewController()
            detailVC.artist = artist
            navigationController?.pushViewController(detailVC, animated: true)
        case .work(let artist, let work):
            let detailVC = ArtDetailViewController()
            detailVC.artist = artist
            detailVC.selectedWork = work
            navigationController?.pushViewController(detailVC, animated: true)
        }
        searchController.isActive = false
    }
}


extension ArtViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.0) {
            self.searchController.searchBar.isHidden = true
        } completion: { _ in
            self.navigationItem.searchController = nil
            self.searchController.isActive = false
            self.searchController.searchBar.isHidden = false
        }
    }
}
