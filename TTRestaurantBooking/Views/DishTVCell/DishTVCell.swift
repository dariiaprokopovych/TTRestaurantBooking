//
//  DishTVCell.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class DishTVCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var dish: DishModel? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        guard let dish = dish else { return }
        nameLabel?.text = dish.name
        priceLabel?.text = "\(dish.price)"
    }
}
