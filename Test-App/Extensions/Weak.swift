//
//  Weak.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

class Weak<T: AnyObject> {
    weak var value : T?
    init (value: T) {
        self.value = value
    }
}
