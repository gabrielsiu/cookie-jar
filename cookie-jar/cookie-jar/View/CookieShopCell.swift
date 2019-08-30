//
//  CookieShopCell.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-22.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

final class CookieShopCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let points: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, name, points])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(stack)
        imageView.setSizeConstraints(size: nil, referenceHeight: name.widthAnchor, referenceWidth: name.widthAnchor)
        stack.setEdgeConstraints(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(cookie: Cookie) {
        name.text = cookie.name
        points.text = "\(cookie.points) points"
        imageView.image = UIImage(named: cookie.imagePath)
    }
}
