//
//  LoginVC.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - action
    @IBAction func onLogin(_ sender: Any) {
        guard let email = emailTextField.text,
        email.count > 0,
        let password = passwordTextField.text,
            password.count > 0 else {
                showErrorAlert(message: "Please fill required fields")
                return
        }
        NetworkManager.login(email: email, password: password) { [weak self] isSuccess, error, data in
            guard let self = self else { return }
            guard isSuccess, let userModel = data as? UserModel  else {
                self.showErrorAlert(message: error?.localizedDescription)
                return
            }
        }
    }
}
