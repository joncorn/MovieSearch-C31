//
//  MovieListTableViewController.swift
//  MovieSearch-C31
//
//  Created by Jon Corn on 1/31/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // MARK: - Properties
    var movies: [JDCMovie]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
        let movie = movies?[indexPath.row]
        cell.movie = movie
        return cell
    }
}

// MARK: - SearchBarDelegate
extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        JDCMovieController.fetchMovies(with: searchText) { (results) in
            self.movies = results
        }
        // Better UX
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}

