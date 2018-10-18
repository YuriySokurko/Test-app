//
//  UIViewController+Notification.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/18/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func configurationKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChangeFrame), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
    }
    
    @objc func keyboardDidChangeFrame(notification: NSNotification) {
    }
}
