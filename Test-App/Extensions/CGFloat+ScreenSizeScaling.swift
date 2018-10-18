//
//  CGFloat+ScreenSizeScaling.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

extension CGFloat {
    
    static func scaleAccordingToDeviceSize(maximumSize: CGFloat) -> CGFloat {
        var result = maximumSize
        
        if UIScreen.main.bounds.size.height == 480 {
            // iPhone 4
            result = maximumSize * 0.85
        } else if UIScreen.main.bounds.size.height == 568 {
            // IPhone 5
            result = maximumSize * 1
        } else if UIScreen.main.bounds.size.width == 375 {
            // iPhone 6
            result = maximumSize * 1.20
        } else if UIScreen.main.bounds.size.width == 414 {
            // iPhone 6+
            result = maximumSize * 1.30
        } else if UIScreen.main.bounds.size.width == 768 {
            // iPad
            result = maximumSize * 1.35
        }
        
        return result
    }
}

extension NSObject {
    
    static func scaleAccordingToDeviceSize(maximumSize: CGFloat) -> CGFloat {
        var result = maximumSize
        
        if UIScreen.main.bounds.size.height == 480 {
            // iPhone 4
            result = maximumSize * 0.85
        } else if UIScreen.main.bounds.size.height == 568 {
            // IPhone 5
            result = maximumSize * 1
        } else if UIScreen.main.bounds.size.width == 375 {
            // iPhone 6
            result = maximumSize * 1.20
        } else if UIScreen.main.bounds.size.width == 414 {
            // iPhone 6+
            result = maximumSize * 1.30
        } else if UIScreen.main.bounds.size.width == 768 {
            // iPad
            result = maximumSize * 1.35
        }
        
        return result
    }
}

extension NSObject {
    
    static func scaleFontAccordingToDeviceSize(font: UIFont) -> UIFont? {
        let fontSize = scaleAccordingToDeviceSize(maximumSize: font.pointSize)
        
        let updatedFont = UIFont(name: font.fontName, size: fontSize)
        
        return updatedFont
    }
}
