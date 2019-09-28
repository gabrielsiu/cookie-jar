//
//  PurchaseConfirmationView.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-27.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

final class PurchaseConfirmationView: ModalPopupView {
    // MARK: Properties
    private let purchaseConfirmationViewModel: PurchaseConfirmationViewModel
    
    private let confirmationTitle: UILabel = {
        let label = UILabel()
        label.text = "Confirmation"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let confirmationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let cookieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        return imageView
    }()
    
    private let cancelButton: RoundedButton = {
        let button = RoundedButton(title: "Cancel", textColor: .red)
        button.addTarget(nil, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let purchaseButton: RoundedButton = {
        let button = RoundedButton(title: "Purchase", textColor: .brown)
        button.addTarget(nil, action: #selector(purchaseButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var topStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [confirmationTitle, confirmationLabel, cookieImageView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var bottomStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [purchaseButton, cancelButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: Initialization
    init(index: Int) {
        purchaseConfirmationViewModel = PurchaseConfirmationViewModel(dataService: DataService(defaults: UserDefaults.standard), cookieService: CookieService(), index: index)
        super.init(frame: .zero)
        [topStack, bottomStack].forEach { container.addSubview($0) }
        
        topStack.setEdgeConstraints(top: container.topAnchor, bottom: bottomStack.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 20, right: 16))
        bottomStack.setEdgeConstraints(top: topStack.bottomAnchor, bottom: container.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 20, right: 16))
        
        confirmationLabel.text = purchaseConfirmationViewModel.getConfirmationText(index: index)
        cookieImageView.image = UIImage(named: purchaseConfirmationViewModel.getImagePath(index: index))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("PurchaseConfirmationView deinit")
    }
    
    // MARK: Actions
    @objc private func cancelButtonPressed() {
        animateOut()
    }
    
    @objc private func purchaseButtonPressed() {
        if purchaseConfirmationViewModel.canPurchaseCookie() {
            purchaseConfirmationViewModel.purchaseCookie()
            animateOut()
        } else {
            animateOut()
        }
        
    }
}
