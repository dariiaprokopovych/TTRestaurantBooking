//
//  OwnerRestaurantsListVC.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class OwnerRestaurantsListVC: UserBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var restaurants: [Restaurant] = []

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    // MARK: - private
    private func loadData() {
        OwnerNetworkManager.getRestaurants(user: user) { isSuccess, error, data in
            DispatchQueue.main.async {
                guard isSuccess, let restaurants = data as? [Restaurant] else {
                    self.showErrorAlert(message: error?.localizedDescription)
                    return
                }
                self.restaurants = restaurants
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "\(OwnerRestaurantCell.self)", bundle: nil), forCellReuseIdentifier: "\(OwnerRestaurantCell.self)")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    fileprivate func showRestaurantProfile(restaurant: Restaurant) {
        guard let vc = UIStoryboard(name: "Owner", bundle: nil).instantiateViewController(withIdentifier: "\(RestaurantProfileVC.self)") as? RestaurantProfileVC else { return }
        vc.restaurant = restaurant
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension OwnerRestaurantsListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(OwnerRestaurantCell.self)") as? OwnerRestaurantCell else {
            return UITableViewCell()
        }
        cell.restaurant = restaurants[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showRestaurantProfile(restaurant: restaurants[indexPath.row])
    }
}
