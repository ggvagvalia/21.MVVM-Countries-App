//
//  CountryViewModelExtensions.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/25/24.
//

import Foundation
import UIKit

// MARK: - Searchfunc
extension CountryViewModel {
    public func inSearchModel(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        guard let countries = allCountries() else {
            return
        }
        
        self.filteredCountries = countries
        
        if let searchText = searchBarText?.lowercased(), !searchText.isEmpty {
            self.filteredCountries = countries.filter { $0.name?.common?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
    }
}

