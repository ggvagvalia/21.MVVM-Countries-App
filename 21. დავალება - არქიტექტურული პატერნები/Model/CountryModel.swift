//
//  CountryModel.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/24/24.
//

import Foundation

struct CountryModel: Codable {
    var name: CountryName?
    var currencies: Mdl?
    var capital: [String]?
    var altSpellings: [String]?
    var region: String?
    var flag: String?
    var maps: Maps?
    var flags: Flags?
    var borders: [String]?
    var population: Int?
    var languages: Language?
    var independent: Bool?
    
    struct CountryName: Codable {
        var common: String?
        var official: String?
        var nativeName: NativeStruct?
        
        struct NativeStruct: Codable {
            var ron: RonStruct?
            
            struct RonStruct: Codable {
                var official: String?
                var common: String?
            }
        }
    }
    
    struct Mdl: Codable {
        var MDL: MDLStruct?
        
        struct MDLStruct: Codable {
            var name: String?
            var symbol: String?
        }
    }
    
    struct Maps: Codable {
        var googleMaps: String?
        var openStreetMaps: String?
    }
    
    struct Flags: Codable {
        var png: String?
        var svg: String?
        var alt: String?
    }
    
    struct Language: Codable {
        var kat: String?
    }
    
}
