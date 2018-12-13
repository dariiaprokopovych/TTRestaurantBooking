//
//  RestaurantListVC.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/23/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class RestaurantListVC: UserBaseViewController {

    var restaurants: [Restaurant] = []
    var dateFrom: Date!
    var dateTo: Date!
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - private
    private func setupTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(UINib(nibName: "\(RestaurantCell.self)", bundle: nil), forCellReuseIdentifier: "\(RestaurantCell.self)")
    }

    private func showSuccessPopUp(name: String) {
        let alert = UIAlertController(title: "Success", message: "You reservation in \(name) is created with success", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            alert.dismiss(animated: true, completion: {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension RestaurantListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RestaurantCell.self)") as? RestaurantCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.restaurant = restaurants[indexPath.row]
        return cell
    }
    
}

extension RestaurantListVC: RestaurantCellDelegate {
    
    func bookRestaurant(restaurant: Restaurant) {
        UIActivityIndicatorView.startShowing()
        ClientNetworkManager.bookRestaurant(restaurant: restaurant, userId: user.id, dateTo: dateTo, dateFrom: dateFrom) {  isSuccess, error in
            //guard let self = self else { return }
            DispatchQueue.main.async {
                UIActivityIndicatorView.stopShowing()
                guard isSuccess else {
                    self.showErrorAlert(message: error?.localizedDescription)
                    return
                }
                self.showSuccessPopUp(name: restaurant.name)
            }
        }
    }
    
}
