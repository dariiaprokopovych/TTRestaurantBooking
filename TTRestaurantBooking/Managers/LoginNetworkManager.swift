//
//  NetworkManager.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

typealias Completion = ( _ isSuccess: Bool, _ error: Error?, _ data: Any?) -> ()
typealias EmptyCompletion = ( _ isSuccess: Bool, _ error: Error?) -> ()

class LoginNetworkManager {

    static func login(email: String, password: String, completion: @escaping Completion) {
        let mockUser = UserModel()
        mockUser.role = .owner
        completion(true, nil, mockUser)
    }
    
    static func register(role: Role, email: String, password: String, name: String, age: Int, sex: Sex, completion: @escaping Completion) {
        let mockUser = UserModel()
        mockUser.role = role
        completion(true, nil, mockUser)
    }
}
