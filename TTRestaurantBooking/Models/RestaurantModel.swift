//
//  RestaurantModel.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import Foundation

class Restaurant: Codable {
    var name: String = "wdwdw"
    var workFrom: Date = Date()
    var workTill: Date = Date()
    var address: String = ""
    var menu: [DishModel] = []
    var tables: [TableModel] = []
    var restaurantId: Int = -1
    var userId: Int = -1
    
    enum CodingKeys: String, CodingKey {
        case name
        case menu
        case workTill = "openTill"
        case workFrom = "openFrom"
        case tables
        case address
        case restaurantId
        case userId
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(address, forKey: .address)
        try container.encode(name, forKey: .name)
        try container.encode(menu, forKey: .menu)
        try container.encode(tables, forKey: .tables)
        let workTillString = workTill.stringWithFormat(format: .fullWithoutSeconds)
        try container.encode(workTillString, forKey: .workTill)
        let workFromString = workFrom.stringWithFormat(format: .fullWithoutSeconds)
        try container.encode(workFromString, forKey: .workFrom)
        if restaurantId != -1 {
            try container.encode(restaurantId, forKey: .restaurantId)
        }
        if userId != -1 {
            try container.encode(userId, forKey: .userId)
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        userId = try container.decode(Int.self, forKey: .userId)
        restaurantId = try container.decode(Int.self, forKey: .restaurantId)
        menu = try container.decode([DishModel].self, forKey: .menu)
        tables = try container.decode([TableModel].self, forKey: .tables)
        let workTillString = try container.decode(String.self, forKey: .workTill)
        workTill = workTillString.date(format: .fullWithoutSeconds)
        let workFromString = try container.decode(String.self, forKey: .workFrom)
        workFrom = workFromString.date(format: .fullWithoutSeconds)
    }
    
    init() { }
}
