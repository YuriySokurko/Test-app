//
//  CreateUsersRequest.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/17/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation
import Alamofire

class CreateUsersRequest: ServerRequest<String> {
    
    var p2pModel: p2pModel
    
    //MARK: - Interface -
    
    init(withModel: p2pModel) {
        self.p2pModel = withModel
    }
        
    func resumeWithCompletionClosure(closure: @escaping (CreateUsersRequest) ->()) {
        if let image = p2pModel.image {
            loadInImageStorage(image: image) { url in
                self.createUser(imageUrl: url, closure: {
                    closure(self)
                })
            }
        } else {
            createUser(imageUrl: nil) {
                closure(self)
            }
        }
    }
    
    private func createUser(imageUrl: String?, closure: @escaping ()->()) {
        var parameters = Parameters()
        parameters = ["user": ["first_name" : p2pModel.user.firstName,
                               "last_name" : p2pModel.user.lastName,
                               "email"    : p2pModel.user.email,
                               "image_url" : imageUrl]]
        
        Alamofire.request(baseUrlString + "users.php",
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default).responseString { (response) in
                            
                            switch response.result {
                            case .success(let responseObject):
                                if !responseObject.isEmpty {
                                    self.responseMessage = "Some error occured."
                                }
                            case .failure(let error):
                                self.error = error as NSError?
                            }
                            
                            closure()
        }
    }

}
