//
//  ToDoListVC.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-07.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

class ToDoListVC: UIViewController {

    // MARK: Properties
    var navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: "To-Do List")
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(addToDoItem))
        navItem.rightBarButtonItem = addItem
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoItemCell")
        return tableView
    }()
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [navBar, tableView].forEach { view.addSubview($0) }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupLayout()
    }
    
    private func setupLayout() {
        navBar.setConstraints(top: view.safeAreaLayoutGuide.topAnchor, bottom: tableView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        tableView.setConstraints(top: navBar.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    
    // MARK:
    @objc func addToDoItem() {
        
    }


}

// MARK: - Extensions
extension ToDoListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
    
    
}

extension UIView {
    func setConstraints(top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor, padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
    }
}
