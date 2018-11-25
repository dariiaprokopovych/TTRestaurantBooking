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
    var menu: [DishModel] = [DishModel(), DishModel()]
    var tables: [TableModel] = [TableModel(), TableModel(), TableModel()]
    
    enum CodingKeys: String, CodingKey {
        case name
        case menu
        case workTill = "openTill"
        case workFrom = "openFrom"
        case tables
        case address
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        menu = try container.decode([DishModel].self, forKey: .menu)
        tables = try container.decode([TableModel].self, forKey: .tables)
        let workTillString = try container.decode(String.self, forKey: .workTill)
        workTill = workTillString.date(format: .fullWithoutSeconds)
        let workFromString = try container.decode(String.self, forKey: .workFrom)
        workFrom = workFromString.date(format: .fullWithoutSeconds)
    }
}
