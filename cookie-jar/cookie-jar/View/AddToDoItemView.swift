//
//  AddToDoItemView.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-10.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

protocol ToDoCreationDelegate {
    func createNewToDoItem(title: String, points: Int)
}

class AddToDoItemView: UIView {
    
    // MARK: Properties
    var toDoCreationDelegate: ToDoCreationDelegate!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Enter the new to-do item:"
        label.textAlignment = .center
        return label
    }()
    
    private let toDoItemTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "New to-do"
        return textField
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Select the amount of points to be rewarded upon completing this task:"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let pointsControl: UISegmentedControl = {
        let points = ["0", "1", "2", "3"]
        let segmentedControl = UISegmentedControl(items: points)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.backgroundColor = .white
        return segmentedControl
    }()
    
    private let addToDoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to-do", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor.brown.cgColor
        button.addTarget(nil, action: #selector(addToDoButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var topStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, toDoItemTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var bottomStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pointsLabel, pointsControl, addToDoButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK: Animations
    @objc private func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    @objc private func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc private func addToDoButtonPressed() {
        toDoCreationDelegate.createNewToDoItem(title: toDoItemTextField.text ?? "", points: <#T##Int#>)
    }
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.frame = UIScreen.main.bounds
        
        self.addSubview(container)
        [topStack, bottomStack].forEach { container.addSubview($0) }
        
        container.centerView(yAnchor: self.centerYAnchor, xAnchor: self.centerXAnchor)
        container.setSizeConstraints(size: nil, referenceHeight: self.heightAnchor, referenceWidth: self.widthAnchor, heightMultiplier: 0.4, widthMultiplier: 0.75)
        topStack.setEdgeConstraints(top: container.topAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16))
        bottomStack.setEdgeConstraints(top: nil, bottom: container.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 20, right: 16))
        
        animateIn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
