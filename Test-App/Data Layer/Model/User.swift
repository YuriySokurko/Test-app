//
//  User.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

class User: NSObject {
    
    /* User's ID. */
    var userId: String?
    
    /* User's first name. */
    var firstName: String?
    
    /* User's last name. */
    var lastName: String?
    
    /* User's email. */
    var email: String?
    
    /* User's icon. */
    var imageUrl: URL?
    
    
    convenience init(firstName: String, lastName: String, email: String, id: String) {
        self.init()
        
        self.userId = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }

    //MARK: - Parsing -
    
    convenience init(withDictionary dictionary: Dictionary<String, AnyObject>) {
        self.init()
        
        if let id = dictionary["id"] as? String {
            self.userId = id
        }
        
        if let emailAddress = dictionary["email"] as? String {
            self.email = emailAddress
        }
        
        if let firstName = dictionary["first_name"] as? String {
            self.firstName = firstName
        }
        
        if let lastName = dictionary["last_name"] as? String {
            self.lastName = lastName
        }
        
        if let imageUrl = dictionary["image_url"] as? String {
            self.imageUrl = URL(string: imageUrl)
        }
    }
}
