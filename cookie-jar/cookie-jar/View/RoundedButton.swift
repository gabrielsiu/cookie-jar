//
//  RoundedButton.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-17.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

final class RoundedButton: UIButton {
    init(title: String, textColor: UIColor) {
        super.init(frame: .zero)
        setTitleColor(textColor, for: .normal)
        setTitle(title, for: .normal)
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
