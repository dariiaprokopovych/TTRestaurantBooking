//
//  DishModel.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class DishModel: Codable {
    var name: String = "Carbonara"
    var price: Int = 150
    var dishId: Int = -1
    var restaurantId: Int = -1
    
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case dishId
        case restaurantId
    }
}
