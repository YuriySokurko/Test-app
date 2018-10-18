//
//  Storyboard.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

public enum Controllers: String {
    
    case generalView = "GeneralViewControllerIdentifier"
    case signUpView  = "SignUpIdentifier"
    
    public subscript<T: UIViewController>(description: T) -> Controllers {
        let desc: String = String(describing: description.self)

        switch desc {
        case "GeneralViewController":
            return .generalView
        case "SignUpViewController":
            return .signUpView
        default:
            break
        }
        
        return .generalView
    }
}

public enum Storyboard: String {
    
    case general = "General"
    case signUp  = "SignUp"

    public static func load<T: UIViewController>(from type: Storyboard, with identifier: Controllers, bundle: Bundle? = nil) -> T? {
        return load(from: type, identifier: identifier, bundle: bundle)
    }
    
    public static func load<T: UIViewController>(from type: Storyboard, identifier: Controllers, bundle: Bundle? = nil) -> T? {
        let currBundle = bundle ?? Bundle(for: T.self)
        let storyboard = UIStoryboard(name: type.rawValue, bundle: currBundle)
        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as? T else {return nil}
        
        return vc
    }
    
    public static func loadInitial<T: UIViewController>(from type: Storyboard, bundle: Bundle? = nil) -> T? {
        let currBundle = bundle ?? Bundle(for: T.self)
        let storyboard = UIStoryboard(name: type.rawValue, bundle: currBundle)
        guard let vc = storyboard.instantiateInitialViewController() as? T else {return nil}
        
        return vc
    }
}
