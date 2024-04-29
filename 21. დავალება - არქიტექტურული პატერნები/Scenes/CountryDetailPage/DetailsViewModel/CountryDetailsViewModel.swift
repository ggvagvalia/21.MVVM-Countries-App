//
//  CountryDetailsViewModel.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/25/24.
//

import Foundation


class CountryDetailsViewModel {
    
    // MARK: - Properties
    private var country: CountryModel
    var onFetchImage: ((Data) -> Void)?
    
    var officialCountryNameTitle: String {
        country.name?.official ?? "country name not available"
    }
    
    var flagsInfo: String {
        country.flags?.alt ?? "flag data not available"
    }
    
    var independentInfo: String {
        country.independent?.description ?? "Data not available"
    }
    
    var altSpelling: String {
        country.altSpellings?.last ?? "Spelling data not available"
    }
    
    var capital: String {
        country.capital?.first ?? "Capital data not available"
    }
    
    var population: String {
        String(country.population ?? 0)
    }
    
    var region: String {
        country.region ?? "region data not available"
    }
    
    var borders: String {
        country.borders?.joined(separator: ", ") ?? "neighbors data not available"
    }
    
    var googleMaps: String? {
        country.maps?.googleMaps
    }
    
    var openStreetMaps: String? {
        country.maps?.openStreetMaps
    }
    
    init(country: CountryModel) {
        self.country = country
    }
    
    private func fetchCountryFlag() {
        if let imageUrl = URL(string: country.flags?.png ?? "") {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.onFetchImage?(data)
                    }
                }
            }.resume()
        }
    }
    
    // MARK: - ChildMethod?
    func loadFlag() {
        fetchCountryFlag()
    }
    
}

