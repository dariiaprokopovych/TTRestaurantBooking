//
//  UserModel.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

enum Sex: Int {
    case male
    case female
}

enum Role: Int {
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

class UserModel {
    var id: Int = -1
    var role: Role = Role(rawValue: 0)!
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var age: Int = -1
    
}
