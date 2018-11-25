//
//  RestaurantProfileVC.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class RestaurantProfileVC: UserBaseViewController {
    
    @IBOutlet weak var dishesTableView: UITableView!
    @IBOutlet weak var tablesTableView: UITableView!
    @IBOutlet weak var tableTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dishesTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var workFromTextField: UITextField!
    @IBOutlet weak var workToTextField: UITextField!
    
    private let cellHeight: CGFloat = 44.0
    private var dishes: [DishModel] = []
    private var tables: [TableModel] = []
    private var selectedIndex: Int?
    private let fromHoursPicker: UIDatePicker = UIDatePicker()
    private let toHoursPicker: UIDatePicker = UIDatePicker()
    var restaurant: Restaurant?
    
    // MARK: - lige cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTextFields()
        seupRestaurantUI()
        reloadData()
    }
    
    // MARK: - actions
    @IBAction func onSave(_ sender: Any) {
        guard let name = nameTextField.text, name.count > 0,
            dishes.count > 0, tables.count > 0,
            (workFromTextField.text?.count ?? 0) > 0,
            (workToTextField.text?.count ?? 0) > 0 else {
                showErrorAlert(message: "Please fill all required data")
                return
        }
    }
    
    @IBAction func onAddNewDish(_ sender: Any) {
        showNewDishScreen()
    }
    
    @IBAction func onAddNewTable(_ sender: Any) {
        showNewTableScreen()
    }
    
    @objc func pickerChange(picker: UIDatePicker) {
        switch picker {
        case fromHoursPicker:
            workFromTextField.text = picker.date.stringWithFormat(format: .time)
        case toHoursPicker:
            workToTextField.text = picker.date.stringWithFormat(format: .time)
        default:
            break;
        }
    }
    
    // MARK: - navigation
    private func showNewDishScreen(dish: DishModel? = nil) {
        guard let vc = UIStoryboard(name: "Owner", bundle: nil).instantiateViewController(withIdentifier: "\(CreateDishVC.self)") as? CreateDishVC else { return }
        vc.delegate = self
        if let dish = dish {
            vc.dish = dish
        } else {
            selectedIndex = nil
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showNewTableScreen(table: TableModel? = nil) {
        guard let vc = UIStoryboard(name: "Owner", bundle: nil).instantiateViewController(withIdentifier: "\(CreateTableVC.self)") as? CreateTableVC else { return }
        vc.delegate = self
        if let table = table {
            vc.table = table
        } else {
            selectedIndex = nil
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - private
    private func seupRestaurantUI() {
        guard let restaurant = restaurant else { return }
        nameTextField.text = restaurant.name
        workToTextField.text = restaurant.workTill.stringWithFormat(format: .time)
        workFromTextField.text = restaurant.workFrom.stringWithFormat(format: .time)
        dishes = restaurant.menu
        tables = restaurant.tables
        reloadData()
    }
    
    fileprivate func reloadData() {
        dishesTableViewHeight.constant = CGFloat(dishes.count) * cellHeight
        dishesTableView.reloadData()
        tableTableViewHeight.constant = CGFloat(tables.count) * cellHeight
        tablesTableView.reloadData()
        view.layoutIfNeeded()
    }
    
    private func setupTableView() {
        dishesTableView.register(UINib(nibName: "\(DishTVCell.self)", bundle: nil), forCellReuseIdentifier: "\(DishTVCell.self)")
        dishesTableView.tableFooterView = UIView(frame: .zero)
        tablesTableView.register(UINib(nibName: "\(TableTVCell.self)", bundle: nil), forCellReuseIdentifier: "\(TableTVCell.self)")
        tablesTableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setupTextFields() {
        fromHoursPicker.addTarget(self, action: #selector(pickerChange(picker:)), for: .valueChanged)
        toHoursPicker.addTarget(self, action: #selector(pickerChange(picker:)), for: .valueChanged)
        fromHoursPicker.datePickerMode = .time
        toHoursPicker.datePickerMode = .time
        workToTextField.inputView = toHoursPicker
        workFromTextField.inputView = fromHoursPicker
    }
}

extension RestaurantProfileVC: CreateDishVCDelegate {
    func createDish(dish: DishModel) {
        if let selectedIndex = selectedIndex {
            dishes[selectedIndex] = dish
            self.selectedIndex = nil
        } else {
            dishes.append(dish)
        }
        reloadData()
    }
}

extension RestaurantProfileVC: CreateTableDelegate {
    func createTable(table: TableModel) {
        if let selectedIndex = selectedIndex {
            tables[selectedIndex] = table
            self.selectedIndex = nil
        } else {
            tables.append(table)
        }
        reloadData()
    }
}

extension RestaurantProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dishesTableView {
            return dishes.count
        }
        return tables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == dishesTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(DishTVCell.self)") as? DishTVCell else { return UITableViewCell() }
            cell.dish = dishes[indexPath.row]
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TableTVCell.self)") as? TableTVCell else { return UITableViewCell() }
        cell.table = tables[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if tableView == dishesTableView {
                self.dishes.remove(at: indexPath.row)
            } else if tableView == tablesTableView {
                self.tables.remove(at: indexPath.row)
            }
            reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        if tableView == dishesTableView {
            showNewDishScreen(dish: dishes[indexPath.row])
        } else {
            showNewTableScreen(table: tables[indexPath.row])
        }
    }
}
