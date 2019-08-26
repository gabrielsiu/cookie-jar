//
//  Cookie.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-19.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import Foundation

struct Cookie: Codable {
    var name: String
    var points: Int
    var imagePath: String
    
    init(name: String, points: Int, imagePath: String) {
        self.name = name
        self.points = points
        self.imagePath = imagePath
    }
}
