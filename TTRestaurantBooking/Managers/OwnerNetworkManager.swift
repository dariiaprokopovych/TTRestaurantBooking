//
//  OwnerNetworkManager.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class OwnerNetworkManager {
    static func getRestaurants(user: UserModel, completion: @escaping Completion) {
        completion(true, nil, [Restaurant(), Restaurant(), Restaurant(), Restaurant()])
    }
}
