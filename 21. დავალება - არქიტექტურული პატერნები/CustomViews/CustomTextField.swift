//
//  CustomTextField.swift
//  22. დავალება - Data Persistence
//
//  Created by gvantsa gvagvalia on 4/26/24.
//

import UIKit

class CustomTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        //        let placeholderColor = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        font = UIFont.boldSystemFont(ofSize: 14)
        layer.cornerRadius = 20
        layer.borderWidth = 1.0
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftViewMode = .always
        backgroundColor = UIColor.lightGray
        borderStyle = .roundedRect
        layer.borderColor = UIColor.lightGray.cgColor
        borderStyle = .none
        backgroundColor = .quaternarySystemFill
        textColor = .label
    }
}
