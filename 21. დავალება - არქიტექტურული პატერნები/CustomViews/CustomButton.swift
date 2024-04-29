//
//  CustomButton.swift
//  22. დავალება - Data Persistence
//
//  Created by gvantsa gvagvalia on 4/26/24.
//

import UIKit

class CustomButton: UIButton {
    
    let padding: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton()
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += 2 * padding
        size.height += 2 * padding
        return size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let titleLabel = titleLabel {
            let titleSize = titleLabel.intrinsicContentSize
            let titleX = (bounds.width - titleSize.width) / 2
            let titleY = (bounds.height - titleSize.height) / 2
            titleLabel.frame = CGRect(x: titleX, y: titleY, width: titleSize.width, height: titleSize.height)
        }
    }
    
    func configureButton() {
        
        translatesAutoresizingMaskIntoConstraints = false
        //        setTitleColor(.white, for: .normal)
        backgroundColor = .blue
        layer.cornerRadius = 20
        sizeToFit()
    }
    
    
}
