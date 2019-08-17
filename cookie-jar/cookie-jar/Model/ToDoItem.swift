//
//  ToDoItem.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-10.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import Foundation

struct ToDoItem {
    var title: String
    var points: Int
    var completed: Bool
    
    init(title: String, points: Int) {
        self.title = title
        self.points = points
        self.completed = false
    }
}
