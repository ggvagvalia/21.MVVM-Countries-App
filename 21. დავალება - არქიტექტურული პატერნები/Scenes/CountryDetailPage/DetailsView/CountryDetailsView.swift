//
//  CountryDetailsView.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/25/24.
//

import UIKit
import SafariServices

class CountryDetailsView: UIView {
    
    // MARK: - Properties
    private var viewModel: CountryDetailsViewModel
    var openURLHandler: ((URL) -> Void)?
    
    let detailsScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        return view
    }()
    
    let detailStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 20
        return view
    }()
    
    let countryNameLabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let flagContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        return view
    }()
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let aboutFlagLabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "About the flag:"
        return label
    }()
    
    let flagInfoText: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        return label
    }()
    
    let thinLine: CustomThinLine = {
        let line = CustomThinLine()
        return line
    }()
    
    let basicInfoLabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Basic information:"
        return label
    }()
    
    let independenceHStackView: CustomHStackView = {
        let view = CustomHStackView()
        return view
    }()
    
    let independenceLabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.text = "Independent:"
        return label
    }()
    
    let independenceData: RightAlignedCustomLabel = {
        let label = RightAlignedCustomLabel()
        return label
    }()
    
    let spellingHStackView: CustomHStackView = {
        let view = CustomHStackView()
        return view
    }()
    
    let spellingLabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.text = "Spelling:"
        return label
    }()
    
    let spellingDataLabel: RightAlignedCustomLabel = {
        let label = RightAlignedCustomLabel()
        return label
    }()
    
    let capitalHStackView: CustomHStackView = {
        let view = CustomHStackView()
        return view
    }()
    
    let capitalLabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.text = "Capital:"
        return label
    }()
    
    let capitalDataLabel: RightAlignedCustomLabel = {
        let label = RightAlignedCustomLabel()
        return label
    }()
    
    let populationHStackView: CustomHStackView = {
        let view = CustomHStackView()
        return view
    }()
    
    let populationLabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.text = "Population:"
        return label
    }()
    
    let populationDataLabel: RightAlignedCustomLabel = {
        let label = RightAlignedCustomLabel()
        return label
    }()
    
    let regionHStackView: CustomHStackView = {
        let view = CustomHStackView()
        return view
    }()
    
    let regionlabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.text = "Region:"
        return label
    }()
    
    let regionDataLabel: RightAlignedCustomLabel = {
        let label = RightAlignedCustomLabel()
        return label
    }()
    
    let neighborsHStackView: CustomHStackView = {
        let view = CustomHStackView()
        return view
    }()
    
    let neighborslabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.text = "Neighbors:"
        return label
    }()
    
    let neighborsDataLabel: RightAlignedCustomLabel = {
        let label = RightAlignedCustomLabel()
        return label
    }()
    
    let thinLine2: CustomThinLine = {
        let line = CustomThinLine()
        return line
    }()
    
    let usefulLinksLabel: LeftAlignedCustomLabel = {
        let label = LeftAlignedCustomLabel()
        label.text = "Useful links:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let mapsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let googleMapsView: UIView = {
        let maps = UIView()
        maps.translatesAutoresizingMaskIntoConstraints = false
        maps.isUserInteractionEnabled = true
        return maps
    }()
    
    let googleMapsImage: CustomImageView = {
        let image = CustomImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let openStreetMapsView: UIView = {
        let maps = UIView()
        maps.translatesAutoresizingMaskIntoConstraints = false
        maps.isUserInteractionEnabled = true
        return maps
    }()
    
    let openStreetMapsImage: CustomImageView = {
        let image = CustomImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    init(viewModel: CountryDetailsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        viewModel.loadFlag()
        setupUI()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .tertiarySystemBackground
        loadFlag()
        SetupScrollViewConstraints()
        SetupStackViewConstraints()
        SetupLinksConstraints()
    }
    
    // MARK: - SetupScrollViewConstraints
    func SetupScrollViewConstraints() {
        addSubview(detailsScrollView)
        detailsScrollView.addSubview(detailStackView)
        
        NSLayoutConstraint.activate([
            detailsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            detailsScrollView.topAnchor.constraint(equalTo: topAnchor, constant: 41),
            detailsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            detailsScrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -140),
        ])
    }
    // MARK: - SetupStackViewConstraints
    func SetupStackViewConstraints() {
        detailStackView.addArrangedSubview(countryNameLabel)
        detailStackView.addArrangedSubview(flagContainerView)
        flagContainerView.addSubview(flagImageView)
        detailStackView.addArrangedSubview(aboutFlagLabel)
        detailStackView.addArrangedSubview(flagInfoText)
        detailStackView.addArrangedSubview(thinLine)
        
        detailStackView.addArrangedSubview(basicInfoLabel)
        detailStackView.addArrangedSubview(independenceHStackView)
        independenceHStackView.addArrangedSubview(independenceLabel)
        independenceHStackView.addArrangedSubview(independenceData)
        
        detailStackView.addArrangedSubview(spellingHStackView)
        spellingHStackView.addArrangedSubview(spellingLabel)
        spellingHStackView.addArrangedSubview(spellingDataLabel)
        
        detailStackView.addArrangedSubview(capitalHStackView)
        capitalHStackView.addArrangedSubview(capitalLabel)
        capitalHStackView.addArrangedSubview(capitalDataLabel)
        
        detailStackView.addArrangedSubview(populationHStackView)
        populationHStackView.addArrangedSubview(populationLabel)
        populationHStackView.addArrangedSubview(populationDataLabel)
        
        detailStackView.addArrangedSubview(regionHStackView)
        regionHStackView.addArrangedSubview(regionlabel)
        regionHStackView.addArrangedSubview(regionDataLabel)
        
        detailStackView.addArrangedSubview(neighborsHStackView)
        neighborsHStackView.addArrangedSubview(neighborslabel)
        neighborsHStackView.addArrangedSubview(neighborsDataLabel)
        detailStackView.addArrangedSubview(thinLine2)
        
        NSLayoutConstraint.activate([
            detailStackView.leadingAnchor.constraint(equalTo: detailsScrollView.leadingAnchor, constant: 0),
            detailStackView.topAnchor.constraint(equalTo: detailsScrollView.topAnchor, constant: 0),
            detailStackView.trailingAnchor.constraint(equalTo: detailsScrollView.trailingAnchor, constant: 0),
            detailStackView.bottomAnchor.constraint(equalTo: detailsScrollView.bottomAnchor, constant: 0),
            detailStackView.widthAnchor.constraint(equalTo: detailsScrollView.widthAnchor),
            
            flagContainerView.heightAnchor.constraint(equalToConstant: 220),
            
            flagImageView.leadingAnchor.constraint(equalTo: flagContainerView.leadingAnchor),
            flagImageView.trailingAnchor.constraint(equalTo: flagContainerView.trailingAnchor),
            flagImageView.topAnchor.constraint(equalTo: flagContainerView.topAnchor),
            flagImageView.bottomAnchor.constraint(equalTo: flagContainerView.bottomAnchor),
        ])
        
    }
    
    // MARK: - SetupLinksConstraints
    func SetupLinksConstraints() {
        addSubview(usefulLinksLabel)
        addSubview(mapsView)
        mapsView.addSubview(googleMapsView)
        mapsView.addSubview(openStreetMapsView)
        googleMapsView.addSubview(googleMapsImage)
        openStreetMapsView.addSubview(openStreetMapsImage)
        
        NSLayoutConstraint.activate([
            usefulLinksLabel.topAnchor.constraint(equalTo: detailsScrollView.bottomAnchor, constant: 10),
            usefulLinksLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            
            mapsView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 94),
            mapsView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -94),
            mapsView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            mapsView.heightAnchor.constraint(equalToConstant: 50),
            
            googleMapsView.trailingAnchor.constraint(equalTo: mapsView.trailingAnchor),
            googleMapsView.topAnchor.constraint(equalTo: mapsView.topAnchor),
            googleMapsView.bottomAnchor.constraint(equalTo: mapsView.bottomAnchor),
            googleMapsView.widthAnchor.constraint(equalTo: mapsView.widthAnchor, multiplier: 0.33),
            
            googleMapsImage.leadingAnchor.constraint(equalTo: googleMapsView.leadingAnchor),
            googleMapsImage.trailingAnchor.constraint(equalTo: googleMapsView.trailingAnchor),
            googleMapsImage.topAnchor.constraint(equalTo: googleMapsView.topAnchor),
            googleMapsImage.bottomAnchor.constraint(equalTo: googleMapsView.bottomAnchor),
            
            openStreetMapsView.leadingAnchor.constraint(equalTo: mapsView.leadingAnchor),
            openStreetMapsView.topAnchor.constraint(equalTo: mapsView.topAnchor),
            openStreetMapsView.bottomAnchor.constraint(equalTo: mapsView.bottomAnchor),
            openStreetMapsView.widthAnchor.constraint(equalTo: mapsView.widthAnchor, multiplier: 0.33),
            
            openStreetMapsImage.leadingAnchor.constraint(equalTo: openStreetMapsView.leadingAnchor),
            openStreetMapsImage.trailingAnchor.constraint(equalTo: openStreetMapsView.trailingAnchor),
            openStreetMapsImage.topAnchor.constraint(equalTo: openStreetMapsView.topAnchor),
            openStreetMapsImage.bottomAnchor.constraint(equalTo: openStreetMapsView.bottomAnchor),
        ])
        
        switch traitCollection.userInterfaceStyle {
        case .light:
            googleMapsImage.image = UIImage(named: "Group 18")
            openStreetMapsImage.image = UIImage(named: "Group 19")
            print("lightt")
        case .dark:
            googleMapsImage.image = UIImage(named: "Group 18-darkMode")
            openStreetMapsImage.image = UIImage(named: "Group 19-darkMode")
            print("darkkk")
        default:
            break
        }
    }
    
    // MARK: - Update Labels
    func update() {
        DispatchQueue.main.async { [self] in
            self.countryNameLabel.text = viewModel.officialCountryNameTitle
            self.flagInfoText.text = viewModel.flagsInfo
            self.independenceData.text = viewModel.independentInfo
            self.spellingDataLabel.text = viewModel.altSpelling
            self.capitalDataLabel.text = viewModel.capital
            self.populationDataLabel.text = viewModel.population
            self.regionDataLabel.text = viewModel.region
            self.neighborsDataLabel.text = viewModel.borders
        }
    }
    
    // MARK: - Load Flag Image
    func loadFlag() {
        viewModel.onFetchImage = { [weak self] image in
            let image = UIImage(data: image)
            DispatchQueue.main.async {
                self?.flagImageView.image = image
            }
        }
    }
    // MARK: - SetupTapGesture
    private func setupTapGesture() {
        let googleMapsTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleGoogleMapsTapGesture))
        googleMapsView.addGestureRecognizer(googleMapsTapGesture)
        googleMapsView.isUserInteractionEnabled = true
        
        let openStreetMapsTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOpenStreetMapsTapGesture))
        openStreetMapsView.addGestureRecognizer(openStreetMapsTapGesture)
        openStreetMapsView.isUserInteractionEnabled = true
    }
    
    // if let - nooooooo
    
    @objc private func handleGoogleMapsTapGesture() {
        if let urlString = viewModel.googleMaps,
           let url = URL(string: urlString) {
            openURLHandler?(url)
        }
    }
    
    @objc private func handleOpenStreetMapsTapGesture() {
        if let urlString = viewModel.openStreetMaps,
           let url = URL(string: urlString) {
            openURLHandler?(url)
        }
    }
    
}
