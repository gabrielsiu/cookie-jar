//
//  RoundedButton.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-17.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

final class RoundedButton: UIButton {
    init(title: String, bgColor: CGColor) {
        super.init(frame: .zero)
        setTitleColor(.white, for: .normal)
        setTitle(title, for: .normal)
        layer.backgroundColor = bgColor
        layer.cornerRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
