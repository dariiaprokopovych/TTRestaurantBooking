//
//  TableModel.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class TableModel: Codable {

    var tableNumber: Int = 4
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tableNumber, forKey: .tableNumber)
        try container.encode(amountOfClients, forKey: .amountOfClients)
        if restaurantId != -1 {
            try container.encode(restaurantId, forKey: .restaurantId)
        }
        if tableId != -1 {
            try container.encode(tableId, forKey: .tableId)
        }
    }
}
