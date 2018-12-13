//
//  SearchRestaurantVC.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class SearchRestaurantVC: UserBaseViewController {
    
    private var amountOfPeople = 2
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var fromHoursTextField: UITextField!
    @IBOutlet weak var toHoursTextField: UITextField!
    @IBOutlet weak var personsAmountLabel: UILabel!
    
    private let datePicker: UIDatePicker = UIDatePicker()
    private let fromHoursPicker: UIDatePicker = UIDatePicker()
    private let toHoursPicker: UIDatePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    // MARK: - actions
    @IBAction func onSearch(_ sender: Any) {
        //TODO: unsoment
        guard (fromHoursTextField.text?.count ?? 0) > 0,
        (toHoursTextField.text?.count ?? 0) > 0,
        (dateTextField.text?.count ?? 0) > 0 else {
            showErrorAlert(message: "Please fill all required data")
            return
        }
        UIActivityIndicatorView.startShowing()
        ClientNetworkManager.searchForTable(amountOfPeople: amountOfPeople, date: datePicker.date, fromHours: fromHoursPicker.date, toHours: toHoursPicker.date) { [weak self] (isSuccess, error, data) in
            DispatchQueue.main.async {
                UIActivityIndicatorView.stopShowing()
                guard let self = self else { return }
                guard isSuccess, let restaurants = data as? [Restaurant] else {
                    self.showErrorAlert(message: error?.localizedDescription)
                    return
                }
                self.showRestaurants(restaurants: restaurants)
            }
        }
    }
    
    @IBAction func peopleAmountValueChanged(_ sender: UIStepper) {
        amountOfPeople = Int(sender.value)
        personsAmountLabel.text = amountOfPeople == 1 ? "1 person" : "\(amountOfPeople) persons"
    }
    
    @objc func pickerChange(picker: UIDatePicker) {
        switch picker {
        case fromHoursPicker:
            fromHoursTextField.text = picker.date.stringWithFormat(format: .time)
        case toHoursPicker:
            toHoursTextField.text = picker.date.stringWithFormat(format: .time)
        case datePicker:
            dateTextField.text = datePicker.date.stringWithFormat(format: .date)
        default:
            break;
        }
    }
    
    // MARK: - private
    private func setupTextFields() {
        fromHoursPicker.addTarget(self, action: #selector(pickerChange(picker:)), for: .valueChanged)
        toHoursPicker.addTarget(self, action: #selector(pickerChange(picker:)), for: .valueChanged)
        datePicker.addTarget(self, action: #selector(pickerChange(picker:)), for: .valueChanged)
        fromHoursPicker.datePickerMode = .time
        toHoursPicker.datePickerMode = .time
        datePicker.datePickerMode = .date
        dateTextField.inputView = datePicker
        toHoursTextField.inputView = toHoursPicker
        fromHoursTextField.inputView = fromHoursPicker
    }
    
    private func showRestaurants(restaurants: [Restaurant]) {
        guard let vc = UIStoryboard(name: "Client", bundle: nil).instantiateViewController(withIdentifier: "\(RestaurantListVC.self)") as? RestaurantListVC else { return }
        vc.dateTo = Date.combine(date: datePicker.date, hours: toHoursPicker.date)
        vc.dateFrom = Date.combine(date: datePicker.date, hours: fromHoursPicker.date)
        vc.restaurants = restaurants
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
}
