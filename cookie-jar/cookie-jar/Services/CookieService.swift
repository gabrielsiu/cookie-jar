//
//  CookieService.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-22.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import Foundation

final class CookieService {
    private let cookies = [
        Cookie(name: "Chocolate Chip", points: 1, imagePath: "icons8-cookie-100"),
        Cookie(name: "Macaroon", points: 2, imagePath: "icons8-macaron-100"),
        Cookie(name: "Creme-Filled Chocolate Sandwich", points: 3, imagePath: "icons8-macaron-filled-100"),
        Cookie(name: "Gingerbread Man", points: 2, imagePath: "icons8-gingerbread-man-100")
    ]
    
    func getCookies() -> [Cookie] {
        return cookies
    }
}
