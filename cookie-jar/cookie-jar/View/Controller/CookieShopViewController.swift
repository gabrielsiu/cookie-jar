//
//  CookieShopViewController.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-21.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

class CookieShopViewController: UIViewController {

    // MARK: Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.text = "Cookie Shop"
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.text = "Points: 5"
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, pointsLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private var cookieCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CookieCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [labelStack, cookieCollectionView].forEach { view.addSubview($0) }
        cookieCollectionView.delegate = self
        cookieCollectionView.dataSource = self
        
        labelStack.setEdgeConstraints(top: view.safeAreaLayoutGuide.topAnchor, bottom: cookieCollectionView.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 20, right: 16))
        cookieCollectionView.setEdgeConstraints(top: labelStack.bottomAnchor, bottom: view.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
}

extension CookieShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 80
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CookieCell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
    
}
