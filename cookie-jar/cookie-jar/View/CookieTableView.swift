//
//  CookieTableView.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-21.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

final class CookieTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override func reloadData() {
      super.reloadData()
      self.invalidateIntrinsicContentSize()
      self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
      let height = min(contentSize.height, maxHeight)
      return CGSize(width: contentSize.width, height: height)
    }
}
