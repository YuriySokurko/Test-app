//
//  NSObject+StringFromClass.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

extension NSObject {
    
    static func className() -> String {
        var className = String(describing: self)
        
        if className.contains("<") {
            let components = className.components(separatedBy: "<")
            
            if components.count > 0 {
                className = components[0]
            }
        }
        
        return className
    }
    
    var classNameString: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var classNameString: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
