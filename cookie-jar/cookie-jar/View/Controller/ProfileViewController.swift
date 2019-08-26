//
//  ProfileViewController.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-17.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: Properties
    private let profileViewModel: ProfileViewModel
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.text = "Your Profile"
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [greetingLabel, pointsLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private var cookieTableView: CookieTableView = {
        let tableView = CookieTableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CookieCell")
        tableView.maxHeight = 500
        return tableView
    }()
    
    private let shopButton: RoundedButton = {
        let button = RoundedButton(title: "Cookie Shop", textColor: .brown)
        button.addTarget(nil, action: #selector(toCookieShopVC), for: .touchUpInside)
        return button
    }()
    
    private let resetButton: RoundedButton = {
        let button = RoundedButton(title: "Reset data", textColor: .red)
        button.addTarget(nil, action: #selector(toResetDataView), for: .touchUpInside)
        return button
    }()
    
    private let aboutButton: RoundedButton = {
        let button = RoundedButton(title: "About", textColor: .black)
        button.addTarget(nil, action: #selector(toAboutView), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shopButton, resetButton, aboutButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: Lifecycle
    init(dataService: DataService) {
        profileViewModel = ProfileViewModel(dataService: dataService)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [labelStack, cookieTableView, buttonStack].forEach { view.addSubview($0) }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissScreen))
        cookieTableView.delegate = self
        cookieTableView.dataSource = self
        labelStack.setEdgeConstraints(top: view.safeAreaLayoutGuide.topAnchor, bottom: cookieTableView.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 20, right: 16))
        cookieTableView.setEdgeConstraints(top: labelStack.bottomAnchor, bottom: buttonStack.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 20, right: 0))
        buttonStack.setEdgeConstraints(top: cookieTableView.bottomAnchor, bottom: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 20, right: 16))
        
        pointsLabel.text = profileViewModel.getCurrentPointsString()
    }
    
    deinit {
        print("ProfileViewController deinit")
    }
    
    // MARK: Actions
    @objc func dismissScreen() {
        dismiss(animated: true) {}
    }
    
    @objc func toCookieShopVC() {
        let cookieShopVC = CookieShopViewController(cookieService: CookieService())
        self.navigationController?.pushViewController(cookieShopVC, animated: true)
    }
    
    @objc func toResetDataView() {
        
    }
    
    @objc func toAboutView() {
        self.view.addSubview(AboutView())
    }
}

// MARK: - Delegate Methods
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Cookies"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileViewModel.getCookieList().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
