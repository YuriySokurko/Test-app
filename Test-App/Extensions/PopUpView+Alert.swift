//
//  PopUpView+Alert.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

enum PositionAlert {
    case onTopVC
    case onRootVC
    case onCurrentVC
}

enum TypeAction {
    case notify
    case notify_with(handler: (()->Void)?)
    case logout(handler: (()->Void)?)
    case none
    
    func getActions() -> [UIAlertAction]? {
        switch self {
        case .notify:
            return [UIAlertAction(title: "OK", style: .default)]
        case .notify_with(let handler):
            return [UIAlertAction(title: "OK", style: .default, handler: { _ in handler?() })]
        case .logout(let handler):
            return [UIAlertAction(title: "Not Now", style: .default), UIAlertAction(title: "Sure!", style: .default, handler: { _ in handler?() })]
        default:
            return nil
        }
    }
}

extension NSObject: IPopUpView {
    
    func showSuccessAlert(title: String = "Success", message: String, position alert: PositionAlert = .onRootVC, action: TypeAction = .none, doneButtonHandle: (() -> Void)? = nil) {
        showAlert(title: title, message: message, action: action, doneButtonHandle: doneButtonHandle)
    }
    
    func showFailAlert(title: String = "Error", message: String, action: TypeAction = .none, doneButtonHandle: (() -> Void)? = nil) {
        showAlert(title: title, message: message, action: action, doneButtonHandle: doneButtonHandle)
    }
    
    private func showAlert(title: String, message: String, action: TypeAction, doneButtonHandle: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        action.getActions()?.map { alertController.addAction($0) }
        UIApplication.topVC()?.present(alertController, animated: true)
    }
    
    func hideModalSpinner(_ indicator: UIActivityIndicatorView) {
        DispatchQueue.main.async(execute: {
            indicator.stopAnimating()
            indicator.isHidden = true
        })
    }
    
}

protocol IPopUpView {
    
    func showSuccessAlert(title: String, message: String, action: TypeAction, doneButtonHandle: (() -> Void)?)
    func showFailAlert(title: String, message: String, action: TypeAction, doneButtonHandle: (() -> Void)?)
}

extension IPopUpView {
    func showSuccessAlert(title: String = "Success", message: String, action: TypeAction = .none, doneButtonHandle: (() -> Void)? = nil) {
        showSuccessAlert(title: title, message: message, action: action, doneButtonHandle: doneButtonHandle)
    }
    
    func showFailAlert(title: String = "Error", message: String, action: TypeAction = .none, doneButtonHandle: (() -> Void)? = nil) {
        showFailAlert(title: title, message: message, action: action, doneButtonHandle: doneButtonHandle)
    }
}

extension UIApplication {
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

extension UIApplication {
    class func topVC(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
