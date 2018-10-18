//
//  GeneralCell.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation
import SDWebImage

class GeneralCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    // MARK: - Properties
    
    var user: User! {
        didSet {
            fillCell(by: user)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.layoutIfNeeded()
        userImageView.layer.cornerRadius = userImageView.frame.size.height/2
    }
    
    // Mark: - Private -
    
    private func fillCell(by user: User) {
        userImageView.sd_setImage(with: user.imageUrl,
                   placeholderImage: UIImage(named: "avatar-placeholder"))
        
        if let firstName = user.firstName, !firstName.isEmpty,
            let lastName = user.lastName, !lastName.isEmpty {
            userNameLabel.text = firstName + " " + lastName
        } else {
            userNameLabel.text = "EmptyFirst EmptyLast"
        }
        
        if let email = user.email, !email.isEmpty {
            emailLabel.text = email
        } else {
            emailLabel.text = "empty@empty.com"
        }
    }
}
