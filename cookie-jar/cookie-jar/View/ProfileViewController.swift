//
//  ProfileViewController.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-17.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: Properties
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "Hello, Gabriel"
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.text = "You have 5 points to spend"
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [greetingLabel, pointsLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private var cookieTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CookieCell")
        return tableView
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [labelStack, cookieTableView].forEach { view.addSubview($0) }
        cookieTableView.delegate = self
        cookieTableView.dataSource = self
        labelStack.setEdgeConstraints(top: view.safeAreaLayoutGuide.topAnchor, bottom: cookieTableView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        cookieTableView.setEdgeConstraints(top: labelStack.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
}

// MARK: - Delegate Methods
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Cookies"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
