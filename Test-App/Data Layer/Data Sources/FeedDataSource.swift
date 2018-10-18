//
//  FeedDataSource.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

class FeedDataSource: DataSource {

    override func reloadData() {
        
        if loading { return }
        
        isFirstPage = true
        isLastPage = false
        loading = true
        page = 1
        count = 10
        
        notifyListenersWillLoadItems()
        
        let request = LoadUsersRequest()
        
        page = nextPage()
        
        request.resumeWithCompletionClosure { [weak self] (request) in
            
            self?.loading = false
            self?.sections.removeAll()
            
            if let error = request.hasAlertMessage() {
                self?.notifyListenersDidLoadWithError(error)
            } else {
                if let users = request.responseObject as [User]? {
                    
                    if users.isEmpty {
                        self?.isLastPage = true
                    } else {
                        self?.sections.append(NSMutableArray(array: users))
                    }
                }
                
                self?.notifyListenersDidLoadItems()
            }
        }
    }
}
