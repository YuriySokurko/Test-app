//
//  DataSource.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation

class DataSource: NSObject {
    
    /** Indicates is data loading. */
    var loading: Bool = false
    
    var isFirstPage = true
    
    var isLastPage = false
    
    var count = 10
    
    var page = 1
    
    var listeners = NSMutableArray()
    
    /** Property of mutable array for loading data. */
    var sections:[NSMutableArray] = []
    
    //MARK: - Interface -
    
    func loadNextPage() {
    }
    
    func reloadData() {
    }
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> AnyObject? {
        if sections.indices.contains(indexPath.section) {
            return sections[indexPath.section][indexPath.row] as AnyObject
        }
        return nil
    }

    func numberOfSections() -> Int {
        return self.sections.count
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        if sections.isEmpty {
            return 0
        }
        
        return self.sections[section].count
    }
    
    func nextPage() -> Int {
        page = page + 1
        
        return page
    }
    
    func isInitialPage() -> Bool {
        return page == 1 ? true : false
    }
    
    
    //MARK: - Privates -
    
    private func containsListner(_ listener: AnyObject) -> Int? {
        var index = 0
        
        for listnerWrapper in listeners {
            if let listnerWeak = listnerWrapper as?  Weak<AnyObject> {
                if let unwrappedListner = listnerWeak.value as? NSObject {
                    if let listnerToCheck = listener as? NSObject {
                        if unwrappedListner == listnerToCheck {
                            return index
                        }
                    }
                }
            }
            
            index += 1
        }
        
        return nil
    }
    
    
    //MARK: - Listeners -
    
    func addListener(_ listener: AnyObject) {
        if containsListner(listener) == nil {
            let weakListener = Weak(value: listener)
            listeners.add(weakListener)
        }
    }
    
    func removeListener(_ listener: AnyObject) {
        if let index = containsListner(listener) {
            listeners.removeObject(at: index)
        }
    }
    
    func notifyListenersDidLoadItems() {
        for object in listeners {
            if let weakObject = object as? Weak<AnyObject> {
                if let conformingObject = weakObject.value as? DataSourceDelegate {
                    conformingObject.dataSourceDidLoadItems(sections as AnyObject)
                }
            }
        }
    }
    
    func notifyListenersWillLoadItems() {
        for object in listeners {
            if let weakObject = object as? Weak<AnyObject> {
                if let conformingObject = weakObject.value as? DataSourceDelegate {
                    conformingObject.dataSourceWillLoadItems()
                }
            }
        }
    }
    
    func notifyListenersDidLoadWithError(_ error: String) {
        for object in listeners {
            if let weakObject = object as? Weak<AnyObject> {
                if let conformingObject = weakObject.value as? DataSourceDelegate {
                    conformingObject.dataSourceDidLoadWithError(error)
                }
            }
        }
    }
}

public protocol DataSourceDelegate {
    func dataSourceWillLoadItems()
    
    func dataSourceDidLoadItems(_ items: AnyObject)
    
    func dataSourceDidLoadWithError(_ error: String)
}
