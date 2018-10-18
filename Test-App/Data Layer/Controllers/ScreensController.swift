//
//  ScreensController.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import UIKit

class ScreensController: NSObject {

    //MARK: - Properties -
    
    private var window: UIWindow?
    
    //MARK: - Interface -
    
    func showScreens() {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = UIViewController()
            window?.makeKeyAndVisible()
        }
        
        window?.rootViewController?.displayContentController(setupGeneralViewController())
    }
    
    //MARK: - Private -
    
    private func setupGeneralViewController() -> UIViewController {
        guard let vc: GeneralViewController = Storyboard.load(from: .general, with: .generalView) else {
            assert(false, "Can't load GeneralViewController.")
            return UIViewController()
        }

        return UINavigationController(rootViewController: vc)
    }
}
