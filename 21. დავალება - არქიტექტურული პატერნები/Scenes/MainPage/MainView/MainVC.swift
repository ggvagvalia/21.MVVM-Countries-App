//
//  MainVC.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/24/24.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - Properties
    var countriesViewModel: CountryViewModel
    let searchBar = UISearchController(searchResultsController: nil)
    let countriesTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "countriesCell")
        view.separatorStyle = .none
        return view
    }()
    
    // MARK: - Init
    init() {
        self.countriesViewModel = CountryViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchBar()
        countriesViewModel.delegate = self
        countriesViewModel.viewDidLoad()
        countriesTableView.reloadData()
//        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    // MARK: - SetupUI
    func setupUI() {
        view.addSubview(countriesTableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Countries"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.hidesBackButton = true
        countriesTableView.dataSource = self
        countriesTableView.delegate = self

        NSLayoutConstraint.activate([
            countriesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 21),
            countriesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            countriesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -27),
            countriesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    // MARK: - SetupSearchBar
    private func setupSearchBar() {
        searchBar.searchResultsUpdater = self
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.placeholder = "Search"
        searchBar.isActive = true
        searchBar.searchBar.setImage(UIImage(named: "mic.fill"), for: .bookmark, state: .normal)
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
}


