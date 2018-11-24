//
//  UserBaseViewController.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class UserBaseViewController: BaseViewController {
    
    var user: UserModel!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? UserBaseViewController {
            destinationVC.user = self.user
        }
    }
}
