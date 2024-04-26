//
//  CustomHStackView.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/25/24.
//

import UIKit

class CustomHStackView: UIStackView {
    
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
        axis = .horizontal
    }
}
