//
//  SearchResultViewController.swift
//  ArtApp
//
//  Created by Виталик Молоков on 15.02.2024.
//

import UIKit

class SearchResultsViewController: UITableViewController {
    
    //MARK: - Properties
    var searchResults: [SearchResult] = []
    weak var delegate: SearchResultsDelegate?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
    }
    
    //MARK: - Setups
    private func setupHierarchy() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = .black
    }

    //MARK: - Setup tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let result = searchResults[indexPath.row]
        cell.backgroundColor = .black
            cell.textLabel?.textColor = .white
        switch result {
        case .artist(let artist):
            cell.textLabel?.text = artist.name
        case .work(_, let work):
            cell.textLabel?.text = work.title
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = searchResults[indexPath.row]
                delegate?.didSelectSearchResult(result)
    }
}

