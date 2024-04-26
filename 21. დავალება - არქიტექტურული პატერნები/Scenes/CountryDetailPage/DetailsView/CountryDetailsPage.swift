//
//  CountryDetailsPage.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/25/24.
//

import UIKit
import SafariServices

class CountryDetailsPage: UIViewController {
    
    // MARK: - Properties
    private var detailedInfo: CountryModel
    var viewModel: CountryDetailsViewModel?
    let countryDetailView: CountryDetailsView = {
        let view = CountryDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LifeCycle
    init(detailedInfo: CountryModel) {
        self.detailedInfo = detailedInfo
        super.init(nibName: nil, bundle: nil)
        countryDetailView.openURLHandler = { [weak self] url in
            self?.openURLInSafari(url)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        GetDetailedInfo(for: detailedInfo)
    }
    
    // MARK: - SetupUI
    func setupUI() {
        view.addSubview(countryDetailView)
        
        NSLayoutConstraint.activate([
            countryDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countryDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            countryDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countryDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //        func GetDetailedInfo(for country: CountryModel) {
    //            viewModel?.update(with: detailedInfo, view: countryDetailView)
    //        }
    // MARK: - OpenURLInSafari
    func GetDetailedInfo(for country: CountryModel) {
        countryDetailView.update(with: country)
    }
    // MARK: - SetupTapGesture
    private func openURLInSafari(_ url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
}




