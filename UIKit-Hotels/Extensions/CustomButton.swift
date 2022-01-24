//
//  CustomButton.swift
//  UIKit-Hotels
//
//  Created by Kalabishka Ivan on 24.01.2022.
//

import UIKit

class CustomButton: UIButton {
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    init(
        title: String,
        backgroundColor: UIColor,
        font: UIFont? = .bodyText()
    ){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        titleLabel?.font = font
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
