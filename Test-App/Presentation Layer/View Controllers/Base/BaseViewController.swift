//
//  BaseViewController.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation
import SVProgressHUD

class BaseViewController: UIViewController {
    
    //MARK: - Properties -
    
    var reloadContent: (()-> Void)?
    
    lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    func setupClearNavigationBar() {
        title = ""
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    func openPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }

    func showActivityIndicator() {
        let screenSize: CGRect = UIScreen.main.bounds
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: screenSize.width/2, vertical: screenSize.height/2))
        SVProgressHUD.show()
        view.isUserInteractionEnabled = false
    }
    
    func hideActivityIndicator() {
        SVProgressHUD.dismiss()
        view.isUserInteractionEnabled = true
    }
    
    // MARK: - Selectors
    
    @objc func refreshTable() {
        reloadContent?()
    }
}
