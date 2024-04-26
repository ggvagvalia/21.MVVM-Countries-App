//
//  MainVCExtensions.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/25/24.
//

import Foundation
import UIKit

// MARK: - TableViewExtensions
extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = self.countriesViewModel.inSearchModel(searchBar)
        //        print("Country model count:", countryModel.count)
        return inSearchMode ? self.countriesViewModel.filteredCountries.count : countryModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countriesCell", for: indexPath) as! CustomCell
        let inSearchMode = self.countriesViewModel.inSearchModel(searchBar)
        let countriesDetails = inSearchMode ? countriesViewModel.filteredCountries[indexPath.row] : countryModel[indexPath.row]
        cell.configure(with: countriesDetails)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        countriesViewModel.didSelectRaw(index: indexPath, searchBar: searchBar.searchBar)
    }
}

// MARK: - SearchBar extensions
extension MainVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.countriesViewModel.updateSearchController(searchBarText: searchController.searchBar.text)
        self.countriesTableView.reloadData()
    }
    
}

extension MainVC: CountryViewModelDelegate {
    
    func countriesFetched(_ countries: [CountryModel]) {
        countryModel = countries
        filteredResult = countries
        DispatchQueue.main.async {
            self.countriesTableView.reloadData()
        }
    }
    
    func navigateToDetailsVC(country: CountryModel) {
        let detailsVC = CountryDetailsPage(detailedInfo: country)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}
