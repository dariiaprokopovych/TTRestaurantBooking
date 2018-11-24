//
//  CreateDishVC.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

protocol CreateDishVCDelegate: class {
    func createDish(dish: DishModel)
}

class CreateDishVC: UserBaseViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var priceStepper: UIStepper!
    
    var dish: DishModel?
    
    weak var delegate: CreateDishVCDelegate?
    private var price: Int = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - actions
    @IBAction func onPriceStepper(_ sender: UIStepper) {
        price = Int(sender.value)
        priceLabel.text = "\(price) uah"
    }
    
    @IBAction func onSave(_ sender: Any) {
        guard let name = nameTextField.text, name.count > 0 else {
            return
        }
        if dish == nil {
            dish = DishModel()
        }
        dish!.name = name
        dish!.price = price
        delegate?.createDish(dish: dish!)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - private
    func setupUI() {
        guard let dish = dish else { return }
        nameTextField.text = dish.name
        price = dish.price
        priceStepper.value = Double(dish.price)
        priceLabel.text = "\(price) uah"
    }
}
