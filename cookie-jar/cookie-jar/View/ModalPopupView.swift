//
//  ModalPopupView.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-24.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

class ModalPopupView: UIView {
    
    // MARK: Properties
    let alphaView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        [alphaView, container].forEach { self.addSubview($0) }
        
        alphaView.setEdgeConstraints(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor)
        container.setSizeConstraints(size: nil, referenceHeight: self.heightAnchor, referenceWidth: self.widthAnchor, heightMultiplier: 0.4, widthMultiplier: 0.75)
        container.centerView(yAnchor: self.centerYAnchor, xAnchor: self.centerXAnchor)
        
        alphaView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        animateIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Animations
    @objc func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    @objc func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
}
