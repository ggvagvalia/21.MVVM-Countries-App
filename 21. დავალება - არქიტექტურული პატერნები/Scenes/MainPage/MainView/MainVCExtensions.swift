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
        let searchBarText = searchBar.searchBar.text ?? ""
        return countriesViewModel.numberOfRaws(for: searchBarText)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countriesCell", for: indexPath) as! CustomTableViewCell
        countriesViewModel.cellForRaw(with: cell, at: indexPath, with: searchBar.searchBar.text ?? "")
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
        countriesViewModel.didSelectRaw(index: indexPath)
    }
    
}

// MARK: - SearchBar extensions
extension MainVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.countriesViewModel.updateSearchController(for: searchController.searchBar.text ?? "")
        self.countriesTableView.reloadData()
        //        self.countriesViewModel.filteredCountries = self.countriesViewModel.filteredCountries(for: searchController.searchBar.text) ?? []
        //        self.countriesTableView.reloadData()
    }
    
}

// MARK: - Delegate/Protocol Extention
extension MainVC: CountryViewModelDelegate {
    
    func countriesFetched(_ countries: [CountryModel]) {
        DispatchQueue.main.async {
            self.countriesTableView.reloadData()
        }
    }
    
    func navigateToDetailsVC(country: CountryModel) {
        let countryDetailsViewModel = CountryDetailsViewModel(country: country)
        let detailsVC = CountryDetailsPage(viewModel: countryDetailsViewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
