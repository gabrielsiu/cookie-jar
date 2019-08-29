//
//  ProfileViewModel.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-17.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import Foundation

final class ProfileViewModel {
    private let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: Methods
    func getCookieList() -> [Cookie] {
        return dataService.cookieList
    }
    
    func getCurrentPointsString() -> String {
        let numPoints = dataService.points
        if numPoints == 1 {
            return "You have \(numPoints) point to spend"
        } else {
            return "You have \(numPoints) points to spend"
        }
    }
    
    func resetPoints() {
        dataService.points = 0
        NotificationCenter.default.post(name: Notification.Name(rawValue: NOTIF_POINTS_CHANGED), object: nil)
    }
    
    func resetCookieList() {
        dataService.cookieList.removeAll()
        NotificationCenter.default.post(name: Notification.Name(rawValue: NOTIF_COOKIE_LIST_CHANGED), object: nil)
    }
    
    func resetToDoList() {
        dataService.toDoList.removeAll()
        dataService.completedToDoList.removeAll()
        NotificationCenter.default.post(name: Notification.Name(rawValue: NOTIF_TO_DO_LIST_CHANGED), object: nil)
    }
}
