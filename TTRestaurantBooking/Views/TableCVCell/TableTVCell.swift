//
//  TableTVCell.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class TableTVCell: UITableViewCell {

    @IBOutlet private weak var amountOfPersonsLabel: UILabel!
    
    var table: TableModel? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        guard let table = table else {
            return
        }
        amountOfPersonsLabel.text = table.amountOfClients == 1 ? "1 person" : "\(table.amountOfClients) persons"
    }
    
}
