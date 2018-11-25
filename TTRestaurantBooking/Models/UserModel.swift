//
//  UserModel.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

enum Sex: Int, Codable {
    case male
    case female
}

enum Role: Int, Codable {
    case client
    case owner
    
    var color: UIColor {
        switch self {
        case .client:
            return UIColor.clientYellowColor
        case .owner:
            return UIColor.restaurantOwnerColor
        }
    }
}

class UserModel: Codable {
    var id: Int = -1
    var role: Role = Role(rawValue: 0)!
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var age: Int = -1
    var sex: Sex = Sex(rawValue: 0)!
    
    enum CodingKeys: String, CodingKey {
        case id = "UserId"
        case role = "Role"
        case name = "Name"
        case password = "Password"
        case email = "Email"
        case age = "Age"
        case sex = "Sex"
    }
    
}
