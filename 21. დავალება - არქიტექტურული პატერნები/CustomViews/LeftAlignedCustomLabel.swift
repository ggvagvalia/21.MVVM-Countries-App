//
//  LeftAlignedCustomLabel.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/25/24.
//

import UIKit

class LeftAlignedCustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        text = "Error"
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 11)
        textColor = .label
        numberOfLines = 0
    }
    
}
