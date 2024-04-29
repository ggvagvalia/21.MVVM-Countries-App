//
//  CustomVStackView.swift
//  22. დავალება - Data Persistence
//
//  Created by gvantsa gvagvalia on 4/26/24.
//

import UIKit

class CustomVStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 10
        distribution = .fillProportionally
    }

}
