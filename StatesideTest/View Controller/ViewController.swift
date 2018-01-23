//
//  ViewController.swift
//  StatesideTest
//
//  Created by Ernesto Gonzalez on 1/22/18.
//  Copyright © 2018 Ernesto Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataStack: UIStackView!

    var searchController: UISearchController!
    var dataSource: [Meme]!
    var filteredMemes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        configureSearchBar()
        dataCall()
    }

    private func initialSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(MemeCell.self)
        dataSource = []
        filteredMemes = []
    }

    private func configureSearchBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }

        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by name"
        searchController.searchResultsUpdater = self
        navigationItem.title = "Meme Finder"
        definesPresentationContext = true
    }

    private func dataCall() {
        APIManager.share.getMemes { [unowned self] memes in
            if let memes = memes {
                self.dataSource = memes.sorted { $0.ranking <= $1.ranking }
                DispatchQueue.main.async {
                    self.navigationItem.searchController = self.searchController
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.noDataStack.isHidden = false
                }
            }
        }
    }

    private func isSearchBarEmpy() -> Bool {
        return (searchController.searchBar.text?.isEmpty)!
    }

    fileprivate func isSearching() -> Bool {
        return searchController.isActive && !isSearchBarEmpy()
    }
 }

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching() ? filteredMemes.count : dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MemeCell
        let meme = isSearching() ? filteredMemes[indexPath.row] : dataSource[indexPath.row]
        cell.configureCell(withMeme: meme)
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        searchMemes(withText: searchController.searchBar.text!)
    }

    private func searchMemes(withText text: String) {
        filteredMemes = dataSource.filter({ (meme: Meme) -> Bool in
            return meme.displayName.lowercased().contains(text.lowercased())
        })

        tableView.reloadData()
    }
}

