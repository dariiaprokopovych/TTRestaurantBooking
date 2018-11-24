//
//  ClientNetworkManager.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class ClientNetworkManager {

    static func searchForTable(amountOfPeople: Int, date: Date, fromHours: Date, toHours: Date, completion: @escaping Completion) {
        completion(true, nil, [Restaurant(), Restaurant(), Restaurant()])
    }
    
    static func bookRestaurant(restaurant: Restaurant, completion: @escaping EmptyCompletion) {
        completion(true, nil)
    }
}
