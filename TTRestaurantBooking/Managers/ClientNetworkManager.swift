//
//  ClientNetworkManager.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

class ClientNetworkManager: BaseNetworkManager {

    static func searchForTable(amountOfPeople: Int, date: Date, fromHours: Date, toHours: Date, completion: @escaping Completion) {
        let fromDate = Date.combine(date: date, hours: fromHours).stringWithFormat(format: .fullFormatDate)
        let toDate = Date.combine(date: date, hours: toHours).stringWithFormat(format: .fullFormatDate)
        let string = baseURL + "restaurant/availableTables?pplcount=\(amountOfPeople)&timefrom=\(fromDate)&timetill=\(toDate)"
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
    
    static func bookRestaurant(restaurant: Restaurant, dateTo: Date, dateFrom: Date, completion: @escaping EmptyCompletion) {
        let string = baseURL + "restaurant/addbooking"
        let dataDict = ["tableId" : restaurant.tables[0].tableId,
                    "timeFrom" : dateFrom.stringWithFormat(format: .fullWithoutSeconds),
                    "timeTill" : dateTo.stringWithFormat(format: .fullWithoutSeconds)] as [String : Any]
        let url = URL(string: string)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
        request.httpBody = try JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
        }
        catch let error {
            completion(false, error)
            return
        }
        if let token = UserDefaults.standard.object(forKey: accessTokenKey) as? String {
            request.setValue("Authorization", forHTTPHeaderField: token)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(false, error)
                return
            }
        }
        task.resume()
    }
}
