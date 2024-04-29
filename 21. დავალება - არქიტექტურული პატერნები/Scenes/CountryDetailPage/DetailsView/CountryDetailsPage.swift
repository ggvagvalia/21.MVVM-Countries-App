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
    private let viewModel: CountryDetailsViewModel
    lazy var countryDetailView: CountryDetailsView = {
        let view = CountryDetailsView(viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    init(viewModel: CountryDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        countryDetailView.openURLHandler = { [weak self] url in
            self?.openURLInSafari(url)
        }
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        GetDetailedInfo()
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
    
    // MARK: - OpenURLInSafari
    func GetDetailedInfo() {
        countryDetailView.update()
    }
    // MARK: - SetupTapGesture
    private func openURLInSafari(_ url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
}




