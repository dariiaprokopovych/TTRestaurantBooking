//
//  OwnerRestaurantCell.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class OwnerRestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantTimeLabel: UILabel!
    
    var restaurant: Restaurant? {
        didSet {
            setupUI()
        }
    }
    
    private func setupUI() {
        guard let restaurant = restaurant else { return }
        restaurantNameLabel.text = restaurant.name
    }
}
