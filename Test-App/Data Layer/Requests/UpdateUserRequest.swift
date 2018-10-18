//
//  UpdateUserRequest.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation
import Alamofire

class UpdateUserRequest: ServerRequest<User> {
    
    var p2pModel: p2pModel
    
    //MARK: - Interface -
    
    init(withModel: p2pModel) {
        self.p2pModel = withModel
    }
    
    func resumeWithCompletionClosure(closure: @escaping (UpdateUserRequest) ->()) {
        if let image = p2pModel.image {
            loadInImageStorage(image: image) { url in
                self.updateUser(imageUrl: url, closure: {
                    closure(self)
                })
            }
        } else {
            updateUser(imageUrl: nil) {
                closure(self)
            }
        }
    }
    
    private func updateUser(imageUrl: String?, closure: @escaping ()->()) {
        var parameters = Parameters()
        parameters = ["user": ["first_name" : p2pModel.user.firstName,
                               "last_name" : p2pModel.user.lastName,
                               "email"    : p2pModel.user.email,
                               "image_url" : imageUrl]]

        Alamofire.request(baseUrlString + "edit_user.php?user_id=\(p2pModel.user.userId ?? "")",
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
