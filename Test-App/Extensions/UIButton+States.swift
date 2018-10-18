//
//  UIButton+States.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/16/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import UIKit

extension UIButton {
    
    override open var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.alpha = self.isHighlighted ? 0.5 : 1.0
            }
        }
    }
}

