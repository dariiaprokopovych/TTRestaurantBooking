//
//  OwnerNetworkManager.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class OwnerNetworkManager: BaseNetworkManager {
    static func getRestaurants(user: UserModel, completion: @escaping Completion) {
        let string = baseURL + "restaurant/usersrestaurants?userId=\(user.id)"
        let url = URL(string: string)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = UserDefaults.standard.object(forKey: accessTokenKey) as? String {
            request.setValue("Authorization", forHTTPHeaderField: token)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(false, error, nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let restaurants: [Restaurant] = try JSONDecoder().decode([Restaurant].self, from: data)
                completion(true, nil, restaurants)
            }
            catch let error {
                completion(false, error, nil)
                return
            }
        }
        task.resume()
    }
    
    static func createRestaurant(name: String, workFrom: Date, workTill: Date, dishes: [DishModel], table: [TableModel], completion: @escaping Completion) {
        
    }
}
