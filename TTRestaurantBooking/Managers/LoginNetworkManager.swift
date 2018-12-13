//
//  NetworkManager.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

typealias Completion = ( _ isSuccess: Bool, _ error: Error?, _ data: Any?) -> ()
typealias EmptyCompletion = ( _ isSuccess: Bool, _ error: Error?) -> ()

let accessTokenKey = "access_token"

class LoginNetworkManager: BaseNetworkManager {

    static func login(email: String, password: String, completion: @escaping Completion) {
        let string = baseURL + "user/token?username=\(email)&password=\(password)"
        let url = URL(string: string)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(false, error, nil)
                return
            }
            var dataDict = [String: Any]()
            do {
                dataDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] ?? [:]
            }
            catch let error {
                completion(false, error, nil)
                return
            }
            let token = dataDict[accessTokenKey] as! String
            UserDefaults.standard.set("Bearer \(token)", forKey: accessTokenKey)
            do {
                let userDict = dataDict["userEntity"] as? [String: Any]
                
                let user = try UserModel(from: userDict)
                completion(true, nil, user)
            }
            catch let error {
                completion(false, error, nil)
                return
            }
        }
        task.resume()
    }
    
    static func register(role: Role, email: String, password: String, name: String, age: Int, sex: Sex, completion: @escaping Completion) {
        let mockUser = UserModel()
        mockUser.email = email
        mockUser.age = age
        mockUser.sex = sex
        mockUser.password = password
        mockUser.role = role
        mockUser.name = name
        
        let string = baseURL + "user/regist"
        let url = URL(string: string)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(mockUser)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(false, error, nil)
                return
            }
            var dataDict = [String: Any]()
            do {
                dataDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] ?? [:]
            }
            catch let error {
                completion(false, error, nil)
                return
            }
            let token = dataDict[accessTokenKey]
            UserDefaults.standard.set(token, forKey: accessTokenKey)
            do {
                let userDict = dataDict["userEntity"] as? [String: Any]
                let user = try UserModel(from: userDict)
                completion(true, nil, user)
            }
            catch let error {
                completion(false, error, nil)
                return
            }
        }
        task.resume()
    }
}
