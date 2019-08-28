//
//  PurchaseConfirmationViewModel.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-27.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import Foundation

final class PurchaseConfirmationViewModel {
    private let dataService: DataService
    private let cookieService: CookieService
    private let index: Int
    
    init(dataService: DataService, cookieService: CookieService, index: Int) {
        self.dataService = dataService
        self.cookieService = cookieService
        self.index = index
    }
    
    func getConfirmationText(index: Int) -> String {
        let cookieName = cookieService.cookies[index].name
        let numPoints = cookieService.cookies[index].points
        var confirmation = "Do you want to purchase a \(cookieName) for "
        
        if numPoints == 1 {
            confirmation += "\(numPoints) point?"
        } else {
            confirmation += "\(numPoints) points?"
        }
        return confirmation
    }
    
    func getImagePath(index: Int) -> String {
        return cookieService.cookies[index].imagePath
    }
    
    func purchaseCookie() {
        let purchasedCookie = cookieService.cookies[index]
        if (dataService.points - purchasedCookie.points) >= 0 {
            dataService.points -= purchasedCookie.points
        }
    }
}
