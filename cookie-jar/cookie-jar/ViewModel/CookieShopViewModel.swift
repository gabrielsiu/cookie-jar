//
//  CookieShopViewModel.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-22.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import Foundation

final class CookieShopViewModel {
    private let dataService: DataService
    private let cookieService: CookieService
    
    init(dataService: DataService, cookieService: CookieService) {
        self.dataService = dataService
        self.cookieService = cookieService
    }
    
    func getCurrentPointsString() -> String {
        let numPoints = dataService.points
        return "Points: \(numPoints)"
    }
    
    func getCookies() -> [Cookie] {
        return cookieService.cookies
    }
}
