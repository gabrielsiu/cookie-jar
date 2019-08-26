//
//  DataService.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-25.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import Foundation

final class DataService {
    let defaults: UserDefaults
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    var points: Int {
        get {
            return defaults.integer(forKey: POINTS_KEY)
        }
        set {
            defaults.setValue(newValue, forKey: POINTS_KEY)
        }
    }
    
    var toDoList: [ToDoItem] {
        get {
            guard let listData = defaults.object(forKey: TO_DO_LIST_KEY) as? Data else { return [ToDoItem]() }
            guard let list = try? PropertyListDecoder().decode([ToDoItem].self, from: listData) else { return [ToDoItem]() }
            return list
        }
        set {
            defaults.set(try? PropertyListEncoder().encode(newValue), forKey: TO_DO_LIST_KEY)
        }
    }
    
    var completedToDoList: [ToDoItem] {
        get {
            guard let listData = defaults.object(forKey: COMPLETED_TO_DO_LIST_KEY) as? Data else { return [ToDoItem]() }
            guard let list = try? PropertyListDecoder().decode([ToDoItem].self, from: listData) else { return [ToDoItem]() }
            return list
        }
        set {
            defaults.set(try? PropertyListEncoder().encode(newValue), forKey: COMPLETED_TO_DO_LIST_KEY)
        }
    }
    
    var cookieList: [Cookie] {
        get {
            guard let listData = defaults.object(forKey: COOKIE_LIST_KEY) as? Data else { return [Cookie]() }
            guard let list = try? PropertyListDecoder().decode([Cookie].self, from: listData) else { return [Cookie]() }
            return list
        }
        set {
            defaults.set(try? PropertyListEncoder().encode(newValue), forKey: COOKIE_LIST_KEY)
        }
    }
}
