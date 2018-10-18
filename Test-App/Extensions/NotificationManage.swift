//
//  NotificationManage.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/18/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

protocol NotificationManage {
    func addObserver(for vc: UIViewController, _ sel: Selector, _ name: String)
    func post(_ notification: String, with params: [String: AnyObject]?)
    func removeObserver()
}

extension NotificationManage {
    func post(_ notification: String, with params: [String: AnyObject]? = nil) {
        post(notification, with: params)
    }
}

extension UIViewController: NotificationManage {
    func addObserver(for vc: UIViewController, _ sel: Selector, _ name: String) {
        NotificationCenter.default.addObserver(vc, selector: sel, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    func post(_ notification: String, with params: [String: AnyObject]? = nil) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: notification), object: params)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func removeObserver(by name: String) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name), object: nil)
    }
}
