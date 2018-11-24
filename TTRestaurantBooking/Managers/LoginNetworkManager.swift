//
//  NetworkManager.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

typealias completion = ( _ isSuccess: Bool, _ error: Error?, _ data: Any?) -> ()

class LoginNetworkManager {

    static func login(email: String, password: String, completion: @escaping completion) {
        
    }
    
    static func register(role: Role, email: String, password: String, name: String, age: Int, sex: Sex, completion: @escaping completion) {
        let mockUser = UserModel()
        mockUser.role = role
        completion(true, nil, mockUser)
    }
}
