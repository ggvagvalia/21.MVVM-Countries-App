//
//  CountryViewModel.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/24/24.
//

import Foundation

protocol CountryViewModelDelegate: AnyObject {
    func countriesFetched(_ countries: [CountryModel])
    func navigateToDetailsVC(country: CountryModel)
}

final class CountryViewModel {
    // MARK: - Properties
    weak var delegate: CountryViewModelDelegate?
    var countryModel: [CountryModel] = []
    var filteredCountries: [CountryModel] = []
    var onFetchImage: ((Data) -> Void)?
    private var model: CountryModel
    
    
    init() {
        self.model = CountryModel()
    }
    
    // MARK: - LifeCycle
    func viewDidLoad() {
        getCountryData()
    }
    
    // MARK: - GetData
    private func getCountryData() {
        CountryService.shared.fetchCountryData { [weak self] currentCountry in
            guard let country = currentCountry else { return }
            DispatchQueue.main.async {
                self?.countryModel = country
                self?.delegate?.countriesFetched(currentCountry!)
            }
        }
    }
    
    // MARK: - numberOfRaws
    func numberOfRaws(for searchedText: String) -> Int {
        let searchBarText = searchedText
        if let filteredCountries = filteredCountries(for: searchBarText) {
            return filteredCountries.count
        } else {
            return 0
        }
    }
    
    // MARK: - cellForRawAt
    func cellForRaw(with: CustomTableViewCell, at index: IndexPath, with searchBarText: String?) {
        if let filteredCountries = filteredCountries(for: searchBarText ?? "") {
            let countriesDetails = filteredCountries[index.row]
            with.configure(with: countriesDetails)
        }
    }
    
    // MARK: - IndexPath.Row / SearchBar
    func didSelectRaw(index: IndexPath) {
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
    
    private func fetchCountryFlag(with countriesDetails: CountryModel) {
        if let imageUrl = URL(string: countriesDetails.flags?.png ?? "") {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.onFetchImage?(data)
                    }
                }
            }.resume()
        }
    }
    
    func loadFlag() {
        fetchCountryFlag(with: model)
    }
    
    // MARK: - FilteredCountries
    func filteredCountries(for searchText: String) -> [CountryModel]? {
        guard !searchText.isEmpty else {
            return countryModel
        }
        return countryModel.filter { $0.name?.common?.localizedCaseInsensitiveContains(searchText) ?? false }
    }
    
    //    // MARK: - UpdateSearchController
    public func updateSearchController(for searchBarText: String?) {
        guard let searchText = searchBarText?.lowercased(), !searchText.isEmpty else {
            filteredCountries = countryModel
            return
        }
        filteredCountries = countryModel.filter { $0.name?.common?.localizedCaseInsensitiveContains(searchText) ?? false }
    }
    
}



