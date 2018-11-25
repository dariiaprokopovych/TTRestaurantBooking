//
//  CreateTableVC.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

protocol CreateTableDelegate: class {
    func createTable(table: TableModel)
}

class CreateTableVC: UserBaseViewController {

    @IBOutlet weak var amountOfPersonsLabel: UILabel!
    @IBOutlet weak var amountStepper: UIStepper!
    
    var table: TableModel?
    weak var delegate: CreateTableDelegate?
    private var usersAmount: Int = 2
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - actions
    @IBAction func onSave(_ sender: Any) {
        if table == nil {
            table = TableModel()
        }
        table!.amountOfClients = usersAmount
        delegate?.createTable(table: table!)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClientsStepper(_ sender: UIStepper) {
        usersAmount = Int(sender.value)
        amountOfPersonsLabel.text = "\(usersAmount) persons"
    }
    
    func setupUI() {
        guard let table = table else { return }
        usersAmount = table.amountOfClients
        amountStepper.value = Double(table.amountOfClients)
        amountOfPersonsLabel.text = table.amountOfClients == 1 ? "1 person" : "\(table.amountOfClients) persons"
    }
}
