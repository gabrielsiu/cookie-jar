//
//  ToDoListVM.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-09.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

class ToDoListVM {
    
    // MARK: Properties
    private var toDoList = [ToDoItem]()
    private var completedToDoList = [ToDoItem]()
    private let defaults = UserDefaults.standard
    
    // MARK: Methods
    func createToDoItem(title: String, points: Int) {
        let newToDoItem = ToDoItem(title: title, points: points)
        toDoList.append(newToDoItem)
        notifyTableViewNeedsUpdate()
    }
    
    func deleteToDoItem(index: Int, completed: Bool) {
        if completed {
            completedToDoList.remove(at: index)
        } else {
            toDoList.remove(at: index)
        }
        notifyTableViewNeedsUpdate()
    }
    
    func toggleToDoItem(index: Int, completed: Bool) {
        if completed {
            completedToDoList[index].completed = !completedToDoList[index].completed
            toDoList.append(completedToDoList[index])
            completedToDoList.remove(at: index)
        } else {
            toDoList[index].completed = !toDoList[index].completed
            completedToDoList.append(toDoList[index])
            toDoList.remove(at: index)
        }
        notifyTableViewNeedsUpdate()
    }
    
    func notifyTableViewNeedsUpdate() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "newToDoPosted"), object: nil)
    }
    
    func getToDoList() -> [ToDoItem] {
        return toDoList
    }
    
    func getCompletedToDoList() -> [ToDoItem] {
        return completedToDoList
    }
    
    func getAccessoryType(completed: Bool) -> UITableViewCell.AccessoryType {
        if completed {
            return .checkmark
        } else {
            return .none
        }
    }
    
    func getPointsString(numPoints: Int) -> String {
        if numPoints == 1 {
            return "\(numPoints) point"
        } else {
            return "\(numPoints) points"
        }
    }
}
