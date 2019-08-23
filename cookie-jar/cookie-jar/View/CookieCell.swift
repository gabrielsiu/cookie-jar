//
//  CookieCell.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-22.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

final class CookieCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let points: UILabel = {
        let label = UILabel()
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
        stack.setEdgeConstraints(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // FIXME: Refactor to go thru view model
    func setData(cookie: Cookie) {
        name.text = cookie.name
        points.text = "\(cookie.points) points"
        imageView.image = UIImage(named: cookie.imagePath)
    }
}
