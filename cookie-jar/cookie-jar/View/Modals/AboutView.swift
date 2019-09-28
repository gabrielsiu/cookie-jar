//
//  AboutView.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-23.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

final class AboutView: ModalPopupView {
    // MARK: Properties
    private let appLabel: UILabel = {
        let label = UILabel()
        label.text = "Cookie Jar"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Created by Gabriel Siu"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let thanksLabel: UILabel = {
        let label = UILabel()
        label.text = "Thanks to:"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let creditTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        let attributedString = NSMutableAttributedString(string: "Icons8 for all icons and app icon")
        let url = URL(string: "https://icons8.com")
        attributedString.setAttributes([.link: url!], range: NSMakeRange(0, 6))
        textView.attributedText = attributedString
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return textView
    }()
    
    private let cookieMonsterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icons8-cookie-monster-144")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var topStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appLabel, nameLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var bottomStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thanksLabel, creditTextView])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [topStack, bottomStack].forEach { container.addSubview($0) }
        topStack.setEdgeConstraints(top: container.topAnchor, bottom: bottomStack.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 40, right: 16))
        bottomStack.setEdgeConstraints(top: topStack.bottomAnchor, bottom: container.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 40, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
