//
//  ServerRequest.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseStorage

class ServerRequest<T> : NSObject {
    
    let baseUrlString = "https://cua-users.herokuapp.com/"

    var responseObject: T?
    
    var error: NSError?
    
    var responseMessage: String?
    
    //MARK: - Interface -
    
    func hasAlertMessage() -> String? {
        var messageText: String?
        
        if error != nil || responseMessage != nil {
            if error != nil {
                messageText = NSLocalizedString(error?.localizedDescription ??  "", comment: "")
            } else if let text = responseMessage {
                messageText = text
            }
        }
        
        return messageText
    }
    
    func loadInImageStorage(image: UIImage, closure: @escaping (String?)->()) {
        let imageName = NSUUID.init()
        let storageRef = Storage.storage().reference().child("\(imageName.uuidString).png")
        
        if let uploadData = image.pngData() {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.setDefaultError()
                    closure(nil)
                }
                
                storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        self.setDefaultError()
                        closure(nil)
                    } else {
                        if let storageUrl = url {
                            self.getShortURL(storageUrl, closure: { result in
                                closure(result)
                            })
                        } else {
                            closure(nil)
                        }
                    }
                })
            }
        } else {
            self.setDefaultError()
            closure(nil)
        }
    }
    
    func getShortURL(_ url: URL, closure: @escaping (String?)->()) {
        Alamofire.request("http://tinyurl.com/api-create.php?url=\(url)").responseData { (result) in
            if let data = result.data, let url = String(data: data, encoding: .utf8) {
                closure(url)
            } else {
                closure(nil)
            }
        }
    }
    
    private func setDefaultError()  {
        responseMessage = "Some error occured."
    }
}
