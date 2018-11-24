//
//  RestaurantModel.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import Foundation

class Restaurant {
    var name: String = "wdwdw"
    var workFrom: Date = Date()
    var workTill: Date = Date()
    var dishes: [DishModel] = [DishModel(), DishModel()]
    var tables: [TableModel] = [TableModel(), TableModel(), TableModel()]
}
