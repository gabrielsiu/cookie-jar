//
//  UIView+Constraints.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-10.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

extension UIView {
    func setEdgeConstraints(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
    }
    
    func setSizeConstraints(size: CGSize?, referenceHeight: NSLayoutDimension?, referenceWidth: NSLayoutDimension?, heightMultiplier: CGFloat = 1.0, widthMultiplier: CGFloat = 1.0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let size = size, size.width != .zero && size.height != .zero {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        } else if let height = referenceHeight, let width = referenceWidth {
            heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier).isActive = true
            widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier).isActive = true
        }
    }
    
    func centerView(yAnchor: NSLayoutYAxisAnchor?, xAnchor: NSLayoutXAxisAnchor?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let yAnchor = yAnchor {
            centerYAnchor.constraint(equalTo: yAnchor).isActive = true
        }
        if let xAnchor = xAnchor {
            centerXAnchor.constraint(equalTo: xAnchor).isActive = true
        }
    }
}
