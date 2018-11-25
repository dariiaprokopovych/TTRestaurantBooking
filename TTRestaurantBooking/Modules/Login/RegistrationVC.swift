//
//  RegistrationVC.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class RegistrationVC: BaseViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    
    var role: Role? {
        didSet {
            guard role != nil else { return }
            updateUI()
        }
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - action
    @IBAction func onRegister(_ sender: Any) {
        guard let role = role,
            let name = nameTextField.text, name.count > 0,
            let email = emailTextField.text, email.count > 0,
            let password = passwordTextField.text, password.count > 0,
            let ageText = ageTextField.text, let age = Int(ageText), age > 0,
            let sex = Sex(rawValue: sexSegmentControl.selectedSegmentIndex) else {
                showErrorAlert(message: "Please fill all data")
                return
        }
        
        LoginNetworkManager.register(role: role, email: email, password: password, name: name, age: age, sex: sex) { [weak self] (isSuccess, error, data) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                guard isSuccess, let registrationModel = data as? UserModel else {
                    self.showErrorAlert(message: error?.localizedDescription)
                    return
                }
                self.goNext(for: registrationModel)
            }
        }
    }
    
    private func goNext(for user: UserModel) {
        let vc: UIViewController
        switch user.role {
        case .owner:
            vc = UIStoryboard(name: "Owner", bundle: nil).instantiateInitialViewController()!
        case .client:
            vc = UIStoryboard(name: "Client", bundle: nil).instantiateInitialViewController()!
        }
        if let _vc = vc as? UserBaseViewController {
            _vc.user = user
            navigationController?.pushViewController(_vc, animated: true)
        }
    }
    
    // MARK: - ui
    private func updateUI() {
        view.backgroundColor = role!.color
    }
    
}
