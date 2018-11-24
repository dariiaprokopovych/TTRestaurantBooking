//
//  RoleChoosingVC.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class RoleChoosingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - actions
    @IBAction func onClientAction(_ sender: Any) {
        showRegistrationVC(role: .client)
    }
    
    @IBAction func onOwnerAction(_ sender: Any) {
        showRegistrationVC(role: .owner)
    }
    
    private func showRegistrationVC(role: Role) {
        guard let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "\(RegistrationVC.self)") as? RegistrationVC else { return }
        vc.role = role
        navigationController?.pushViewController(vc, animated: true)
    }
}
