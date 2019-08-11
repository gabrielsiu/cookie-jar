//
//  ToDoListVM.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-09.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import Foundation

class ToDoListVM {
    
    // MARK: Properties
    var toDoList = [ToDoItem]()
    private let defaults = UserDefaults.standard
    
    func createToDoItem(title: String, points: Int) {
        let newToDoItem = ToDoItem(title: title, points: points)
        
    }
}
