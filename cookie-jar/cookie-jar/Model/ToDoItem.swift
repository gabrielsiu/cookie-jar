//
//  ToDoItem.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-10.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import Foundation

struct ToDoItem {
    
    public private(set) var title: String
    public private(set) var points: Int
    public private(set) var completed: Bool
    
    init(title: String, points: Int) {
        self.title = title
        self.points = points
        self.completed = false
    }
}
