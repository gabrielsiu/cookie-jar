//
//  ToDoListVC.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-07.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {
    // MARK: Properties
    private let toDoListViewModel = ToDoListViewModel()
    // TODO: Make dynamic to update with points (maybe with viewmodel)
    private var pointsString: String = {
        return "0 points"
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoItemCell")
        tableView.endEditing(true)
        return tableView
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setEdgeConstraints(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: Notification.Name(rawValue: "toDoListChanged"), object: nil)
    }
    
    private func setUpNavBar() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDoItem))
        let profileItem = UIBarButtonItem(title: pointsString, style: .plain, target: self, action: #selector(presentProfilePopup))
        
        navigationItem.rightBarButtonItems = [addItem, editButtonItem]
        navigationItem.leftBarButtonItem = profileItem
        navigationItem.title = "To-Do List"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Actions
    func updatePoints(indexPath: IndexPath) {
        guard let item = navigationItem.leftBarButtonItem else { return }
        item.title = toDoListViewModel.updatePoints(indexPath: indexPath)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    @objc func addToDoItem() {
        let popup = AddToDoItemView()
        popup.toDoCreationDelegate = self
        self.view.addSubview(popup)
    }
    
    @objc func presentProfilePopup() {
        let profileVC = ProfileViewController()
        profileVC.modalPresentationStyle = .overCurrentContext
        present(profileVC, animated: true, completion: nil)
    }
    
    @objc func refreshTableView() {
        tableView.reloadData()
    }
}

// MARK: - Delegate Methods
extension ToDoListViewController: ToDoCreationDelegate {
    func createNewToDoItem(title: String, points: Int) {
        toDoListViewModel.createToDoItem(title: title, points: points)
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return toDoListViewModel.getToDoList().count
        } else {
            return toDoListViewModel.getCompletedToDoList().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var toDoItem: ToDoItem
        if indexPath.section == 0 {
            toDoItem = toDoListViewModel.getToDoList()[indexPath.row]
        } else {
            toDoItem = toDoListViewModel.getCompletedToDoList()[indexPath.row]
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell = UITableViewCell(style: .value1, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = toDoItem.title
        cell.detailTextLabel?.text = toDoListViewModel.getPointsString(numPoints: toDoItem.points)
        cell.accessoryType = toDoListViewModel.getAccessoryType(completed: toDoItem.completed)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Active"
        } else {
            return "Completed"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoListViewModel.deleteToDoItem(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        updatePoints(indexPath: indexPath)
        toDoListViewModel.toggleToDoItem(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // TODO: Update points when moved
        toDoListViewModel.moveToDoItem(prevIndexPath: sourceIndexPath, newIndexPath: destinationIndexPath)
    }
}
