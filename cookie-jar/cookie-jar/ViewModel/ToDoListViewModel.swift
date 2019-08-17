//
//  ToDoListViewModel.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-09.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

class ToDoListViewModel {
    // MARK: Properties
    private var numPoints: Int = 0
    private var toDoList = [ToDoItem]()
    private var completedToDoList = [ToDoItem]()
    private let defaults = UserDefaults.standard
    
    // MARK: Methods
    func createToDoItem(title: String, points: Int) {
        let newToDoItem = ToDoItem(title: title, points: points)
        toDoList.append(newToDoItem)
        notifyTableViewNeedsUpdate()
    }
    
    func deleteToDoItem(indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            toDoList.remove(at: row)
        } else {
            completedToDoList.remove(at: row)
        }
    }
    
    func toggleToDoItem(indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            toDoList[row].completed = !toDoList[row].completed
            completedToDoList.append(toDoList[row])
            toDoList.remove(at: row)
        } else {
            completedToDoList[row].completed = !completedToDoList[row].completed
            toDoList.append(completedToDoList[row])
            completedToDoList.remove(at: row)
        }
        notifyTableViewNeedsUpdate()
    }
    
    func moveToDoItem(prevIndexPath: IndexPath, newIndexPath: IndexPath) {
        let prevSection = prevIndexPath.section
        let prevRow = prevIndexPath.row
        let newSection = newIndexPath.section
        let newRow = newIndexPath.row
        
        if prevSection == newSection {
            if prevSection == 0 {
                let itemToMove = toDoList[prevRow]
                toDoList.remove(at: prevRow)
                toDoList.insert(itemToMove, at: newRow)
            } else {
                let itemToMove = completedToDoList[prevRow]
                completedToDoList.remove(at: prevRow)
                completedToDoList.insert(itemToMove, at: newRow)
            }
        } else {
            if prevSection == 0 {
                toDoList[prevRow].completed = !toDoList[prevRow].completed
                let itemToMove = toDoList[prevRow]
                toDoList.remove(at: prevRow)
                completedToDoList.insert(itemToMove, at: newRow)
            } else {
                completedToDoList[prevRow].completed = !completedToDoList[prevRow].completed
                let itemToMove = completedToDoList[prevRow]
                completedToDoList.remove(at: prevRow)
                toDoList.insert(itemToMove, at: newRow)
            }
            notifyTableViewNeedsUpdate()
        }
    }
    
    func notifyTableViewNeedsUpdate() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "toDoListChanged"), object: nil)
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
    
    func updatePoints(indexPath: IndexPath) -> String {
        let section = indexPath.section
        let row = indexPath.row
        var points: Int
        
        if section == 0 {
            points = toDoList[row].points
            numPoints += points
        } else {
            points = completedToDoList[row].points
            numPoints -= points
        }
        return getPointsString(numPoints: numPoints)
    }
    
    func getPointsString(numPoints: Int) -> String {
        if numPoints == 1 {
            return "\(numPoints) point"
        } else {
            return "\(numPoints) points"
        }
    }
}
