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
    
    private let cellHeight: CGFloat = 44.0
    private var dishes: [DishModel] = []
    private var tables: [TableModel] = []
    private var selectedIndex: Int?
    
    // MARK: - lige cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        reloadData()
    }

    // MARK: - actions
    @IBAction func onAddNewDish(_ sender: Any) {
        showNewDishScreen()
    }
    
    @IBAction func onAddNewTable(_ sender: Any) {
        
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
    
    // MARK: - private
    fileprivate func reloadData() {
        dishesTableViewHeight.constant = CGFloat(dishes.count) * cellHeight
        dishesTableView.reloadData()
        tablesTableView.reloadData()
        view.layoutIfNeeded()
    }
    
    private func setupTableView() {
        dishesTableView.register(UINib(nibName: "\(DishTVCell.self)", bundle: nil), forCellReuseIdentifier: "\(DishTVCell.self)")
        dishesTableView.tableFooterView = UIView(frame: .zero)
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
        return UITableViewCell()
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
        if tableView == dishesTableView {
            selectedIndex = indexPath.row
            showNewDishScreen(dish: dishes[indexPath.row])
        }
    }
}
