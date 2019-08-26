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

final class AddToDoItemView: ModalPopupView {
    // MARK: Properties
    var toDoCreationDelegate: ToDoCreationDelegate!
    var numPoints: Int!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Enter the new to-do item:"
        label.textAlignment = .center
        return label
    }()
    
    private let toDoItemTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New to-do"
        return textField
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Select the amount of points to be rewarded upon completing this task:"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let pointsControl: UISegmentedControl = {
        let points = ["0", "1", "2", "3"]
        let segmentedControl = UISegmentedControl(items: points)
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.backgroundColor = .white
        segmentedControl.addTarget(nil, action: #selector(onSegmentValueChanged(sender:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private let addToDoButton: RoundedButton = {
        let button = RoundedButton(title: "Add to-do", textColor: .brown)
        button.addTarget(nil, action: #selector(addToDoButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var topStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, toDoItemTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var bottomStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pointsLabel, pointsControl, addToDoButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [topStack, bottomStack].forEach { container.addSubview($0) }
        
        topStack.setEdgeConstraints(top: container.topAnchor, bottom: nil, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16))
        bottomStack.setEdgeConstraints(top: nil, bottom: container.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 20, right: 16))
        
        numPoints = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    @objc private func addToDoButtonPressed() {
        toDoCreationDelegate.createNewToDoItem(title: toDoItemTextField.text ?? "", points: numPoints)
        animateOut()
    }
    
    @objc private func onSegmentValueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            numPoints = 0
        case 1:
            numPoints = 1
        case 2:
            numPoints = 2
        case 3:
            numPoints = 3
        default:
            break
        }
    }
}
