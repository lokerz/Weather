//
//  SearchCityViewController.swift
//  Weather
//
//  Created by Ridwan Abdurrasyid on 24/01/20.
//  Copyright © 2020 ridwan. All rights reserved.
//

import Foundation
import UIKit

extension CitiesTableViewController : UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filteredCities = self.cities.filter({( city : City) -> Bool in
            let searchText = searchController.searchBar.text!.lowercased()
            return city.contains(searchText)
        })
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchBarController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool{
        return !searchBarIsEmpty() && searchBarController.isActive
    }
    
    func setupSearchBar(){
        searchBarController.searchResultsUpdater = self
        searchBarController.searchBar.delegate = self
        searchBarController.definesPresentationContext = true
        searchBarController.hidesNavigationBarDuringPresentation = true
        
        if #available(iOS 9.1, *) {
            searchBarController.obscuresBackgroundDuringPresentation = false
        }
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchBarController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchBarController.searchBar
        }
    }
}



