//
//  CountryViewModel.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/24/24.
//

import Foundation
import UIKit

protocol CountryViewModelDelegate: AnyObject {
    func countriesFetched(_ countries: [CountryModel])
    func navigateToDetailsVC(country: CountryModel)
}

final class CountryViewModel {
    // MARK: - Properties
    private var countryModel: [CountryModel] = []
    //    private let countryService = CountryService.shared
    var filteredCountries: [CountryModel] = []
    weak var delegate: CountryViewModelDelegate?
    
    
    // MARK: - LifeCycle
    func viewDidLoad() {
        getCountryData()
    }
    
    // MARK: - GetData
    private func getCountryData() {
        CountryService.shared.fetchCountryData { [weak self] currentCountry in
            guard let self = self, let country = currentCountry else { return }
            DispatchQueue.main.async {
                self.countryModel = country
                self.delegate?.countriesFetched(currentCountry!)
            }
        }
    }
    
    func fetchCountryData(completion: @escaping ([CountryModel]?) -> Void) {
        CountryService.shared.fetchCountryData { countryModel in
            if let countryModel {
                self.countryModel = countryModel
                completion(countryModel)
            }
        }
    }
    
    func allCountries() -> [CountryModel]? {
        return countryModel
    }
    
    
    // MARK: - IndexPath.Row / SearchBar
    func didSelectRaw(index: IndexPath, searchBar: UISearchBar) {
        let selectedCountry: CountryModel?
        let countries = self.filteredCountries.isEmpty ? self.countryModel : self.filteredCountries
        
        if index.row < countries.count {
            selectedCountry = countries[index.row]
        } else {
            print("Index out of range")
            return
        }
        
        guard let selectedCountry = selectedCountry else {
            print("Failed to retrieve selected country")
            return
        }
        
        delegate?.navigateToDetailsVC(country: selectedCountry)
        
    }
    
    func filteredCountries(for searchText: String) -> [CountryModel]? {
        guard !searchText.isEmpty else {
            return countryModel
        }
        return countryModel.filter { $0.name?.common?.localizedCaseInsensitiveContains(searchText) ?? false }
    }
    
}
