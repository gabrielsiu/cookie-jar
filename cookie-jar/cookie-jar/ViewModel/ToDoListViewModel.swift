//
//  ToDoListViewModel.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-09.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

final class ToDoListViewModel {
    private let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: Methods
    func createToDoItem(title: String, points: Int) {
        let newToDoItem = ToDoItem(title: title, points: points)
        dataService.toDoList.append(newToDoItem)
        notifyTableViewNeedsUpdate()
    }
    
    func deleteToDoItem(indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            dataService.toDoList.remove(at: row)
        } else {
            dataService.completedToDoList.remove(at: row)
        }
    }
    
    func toggleToDoItem(indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            dataService.toDoList[row].completed = !dataService.toDoList[row].completed
            dataService.completedToDoList.append(dataService.toDoList[row])
            dataService.toDoList.remove(at: row)
        } else {
            dataService.completedToDoList[row].completed = !dataService.completedToDoList[row].completed
            dataService.toDoList.append(dataService.completedToDoList[row])
            dataService.completedToDoList.remove(at: row)
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
                let itemToMove = dataService.toDoList[prevRow]
                dataService.toDoList.remove(at: prevRow)
                dataService.toDoList.insert(itemToMove, at: newRow)
            } else {
                let itemToMove = dataService.completedToDoList[prevRow]
                dataService.completedToDoList.remove(at: prevRow)
                dataService.completedToDoList.insert(itemToMove, at: newRow)
            }
        } else {
            if prevSection == 0 {
                dataService.toDoList[prevRow].completed = !dataService.toDoList[prevRow].completed
                let itemToMove = dataService.toDoList[prevRow]
                dataService.toDoList.remove(at: prevRow)
                dataService.completedToDoList.insert(itemToMove, at: newRow)
            } else {
                dataService.completedToDoList[prevRow].completed = !dataService.completedToDoList[prevRow].completed
                let itemToMove = dataService.completedToDoList[prevRow]
                dataService.completedToDoList.remove(at: prevRow)
                dataService.toDoList.insert(itemToMove, at: newRow)
            }
            notifyTableViewNeedsUpdate()
        }
    }
    
    func updatePointsForToggle(indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        var points: Int
        
        if section == 0 {
            points = dataService.toDoList[row].points
            dataService.points += points
        } else {
            points = dataService.completedToDoList[row].points
            dataService.points -= points
        }
    }
    
    func updatePointsForMove(prevIndexPath: IndexPath, newIndexPath: IndexPath) {
        let prevSection = prevIndexPath.section
        let prevRow = prevIndexPath.row
        let newSection = newIndexPath.section
        var points: Int
        
        if prevSection != newSection {
            if prevSection == 0 {
                points = dataService.toDoList[prevRow].points
                dataService.points += points
            } else {
                points = dataService.completedToDoList[prevRow].points
                dataService.points -= points
            }
        }
    }
    
    func notifyTableViewNeedsUpdate() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "toDoListChanged"), object: nil)
    }
    
    func getToDoList() -> [ToDoItem] {
        return dataService.toDoList
    }
    
    func getCompletedToDoList() -> [ToDoItem] {
        return dataService.completedToDoList
    }
    
    func getAccessoryType(completed: Bool) -> UITableViewCell.AccessoryType {
        if completed {
            return .checkmark
        } else {
            return .none
        }
    }
    
    func getCurrentPointsString() -> String {
         return getPointsString(numPoints: dataService.points)
    }
    
    func getPointsString(numPoints: Int) -> String {
        if numPoints == 1 {
            return "\(numPoints) point"
        } else {
            return "\(numPoints) points"
        }
    }
}
