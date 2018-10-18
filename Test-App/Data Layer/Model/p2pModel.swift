//
//  p2pModel.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/17/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

struct p2pModel {
    
    var user: User = User(firstName: "", lastName: "", email: "", id: "")
    var image: UIImage?
    
    init(user: User, image: UIImage?) {
        self.user = user
        self.image = image
    }
}
