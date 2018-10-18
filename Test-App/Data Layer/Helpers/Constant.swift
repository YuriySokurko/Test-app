//
//  Constant.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/18/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

class Constant {

    // MARK: - Validation -
    
    static let NAME_REGX                = "^.{3,15}$"
    static let EMAIL_REGX               = "[A-Z0-9a-z._%+-]{1,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    
    static let EMAIL_DESCRIPTION_ERROR  = "Enter valid email."
    static let NAME_DESCRIPTION_ERROR   = "Charaters limit should be come between 3-10"
}
