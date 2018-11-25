//
//  TableModel.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class TableModel: Codable {

    var tableNumber: Int = -1
    var amountOfClients: Int = 3
    var restaurantId: Int = -1
    var minCheckAmount: Int = 0
    var tableId: Int = -1
    
    enum CodingKeys: String, CodingKey {
        case tableNumber
        case amountOfClients = "seatsAmount"
        case restaurantId
        case minCheckAmount
        case tableId
    }
}
