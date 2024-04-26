//
//  CountryService.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/24/24.
//

import Foundation
class CountryService {
    
    static let shared = CountryService()
    
    func fetchCountryData(completion: @escaping ([CountryModel]?) -> Void) {
        
        let urlString = "https://restcountries.com/v3.1/all"
        guard let urlObject = URL(string: urlString) else {
            print("no url")
            return
        }
        
        URLSession.shared.dataTask(with: urlObject) { data, response, error in
            
            if error != nil {
                print("errorrrr")
                return
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([CountryModel].self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                completion(nil)
                print("error decoding json \(error.localizedDescription)")
            }
            
        }.resume()
    }
}
