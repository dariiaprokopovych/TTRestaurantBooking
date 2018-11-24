//
//  UserModel.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

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
    var role: Role = Role(rawValue: 0)!
    
}
