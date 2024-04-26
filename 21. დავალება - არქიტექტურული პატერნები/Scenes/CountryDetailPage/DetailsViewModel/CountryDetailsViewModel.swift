//
//  CountryDetailsViewModel.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/25/24.
//

import Foundation
import UIKit


protocol CountryDetailsViewModelDelegate: AnyObject {
    func updateView(with detailedInfo: CountryDetailsView)
}

class CountryDetailsViewModel {
    var detailInfo: CountryModel
    var delegate: CountryDetailsViewModelDelegate
    var countryDetailView: CountryDetailsView
    
    
    init(detailInfo: CountryModel, delegate: CountryDetailsViewModelDelegate, countryDetailView: CountryDetailsView) {
        self.detailInfo = detailInfo
        self.delegate = delegate
        self.countryDetailView = countryDetailView
    }
    
    func update(with detailedInfo: CountryModel) {
        self.detailInfo = detailedInfo
        delegate.updateView(with: countryDetailView)
    }
}

//extension CountryDetailsViewModel: CountryDetailsViewModelDelegate {
//    func updateView(with detailedInfo: CountryDetailsView) {
//    }
//}
