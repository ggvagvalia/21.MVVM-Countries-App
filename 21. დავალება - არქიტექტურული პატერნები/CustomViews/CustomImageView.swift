//
//  CustomImageView.swift
//  21. დავალება - არქიტექტურული პატერნები
//
//  Created by gvantsa gvagvalia on 4/25/24.
//

import UIKit

class CustomImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
    }
}
