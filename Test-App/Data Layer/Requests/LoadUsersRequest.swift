//
//  LoadUsersRequest.swift
//  Test-App
//
//  Created by Yuriy Sokirko on 10/15/18.
//  Copyright © 2018 Yuriy Sokirko. All rights reserved.
//

import Foundation
import Alamofire

class LoadUsersRequest: ServerRequest<[User]> {
    
    func resumeWithCompletionClosure(closure: @escaping (LoadUsersRequest) ->()) {

        Alamofire.request(baseUrlString + "users.php",
                          method: .get).responseJSON { (response) in

                            switch response.result {
                            case .success(let responseObject):
                                if let dictionary = responseObject as? [[String : AnyObject]] {
                                    self.responseObject = self.parseResponse(dictionary)
                                }
                            case .failure(let error):
                                self.error = error as NSError?
                            }

                            closure(self)
        }
    }

    //MARK: - Private -

    func parseResponse(_ response: [[String : AnyObject]]) -> [User] {
        var users: [User] = []

        for dictionary in response {
            let item = User(withDictionary: dictionary)
            users.append(item)
        }

        return users.reversed()
    }
}
