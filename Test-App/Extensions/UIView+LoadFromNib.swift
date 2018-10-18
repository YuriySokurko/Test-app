//
//  UIView+LoadFromNib.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

extension UIView {
    
    static var reuseIdentifier: String {
        return className()
    }
    
    static func nib () -> UINib {
        return UINib.init(nibName: className(), bundle: nil)
    }
    
    static func view () -> AnyObject {
        return Bundle.main.loadNibNamed(self.className(), owner: nil, options: nil)?.first as! UIView
    }
}
