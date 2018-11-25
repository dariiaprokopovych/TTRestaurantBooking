//
//  RestaurantCell.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

protocol RestaurantCellDelegate: class {
    func bookRestaurant(restaurant: Restaurant)
}

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var minCheckLabel: UILabel!
    
    weak var delegate: RestaurantCellDelegate?
    var restaurant: Restaurant? {
        didSet {
            restaurantNameLabel?.text = restaurant?.name
            minCheckLabel.text = restaurant?.address
        }
    }
    

    @IBAction func onBook(_ sender: Any) {
        guard let restaurant = restaurant else { return }
        delegate?.bookRestaurant(restaurant: restaurant)
    }
    
}
