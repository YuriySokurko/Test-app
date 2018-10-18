//
//  Font.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

enum Font: String {
    case Regular  = "SFUIText-Regular"
    case Semibold = "SFUIText-Semibold"
    case Medium   = "SFUIText-Medium"
    case Bold     = "SFUIText-Bold"
    
    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
