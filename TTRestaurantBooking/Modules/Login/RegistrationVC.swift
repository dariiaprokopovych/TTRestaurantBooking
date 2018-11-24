//
//  RegistrationVC.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

    var role: Role? {
        didSet {
            guard let role = role else { return }
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - ui
    private func updateUI() {
        view.backgroundColor = role!.color
    }

}
