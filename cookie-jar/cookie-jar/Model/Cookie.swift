//
//  Cookie.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-19.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import Foundation

struct Cookie {
    var title: String
    var cost: Int
    var imagePath: String
    
    init(title: String, cost: Int, imagePath: String) {
        self.title = title
        self.cost = cost
        self.imagePath = imagePath
    }
}
