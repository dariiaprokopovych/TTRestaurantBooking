//
//  UserModel.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import UIKit

enum Sex: Int, Codable {
    case male
    case female
}

enum Role: Int, Codable {
    case client
    case owner
    
    var color: UIColor {
        switch self {
        case .client:
            return UIColor.clientYellowColor
        case .owner:
            return UIColor.restaurantOwnerColor
        }
    }
}

class UserModel: Codable {
    var id: Int = -1
    var role: Role = Role(rawValue: 0)!
    var name: String = ""
    var email: String = "" {
        didSet {
            login = email
        }
    }
    var password: String = ""
    var age: Int = -1
    var sex: Sex = Sex(rawValue: 0)!
    var login: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "UserId"
        case role = "Role"
        case name = "Name"
        case password = "Password"
        case email = "Email"
        case age = "Age"
        case sex = "Sex"
        case login = "Login"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(role, forKey: .role)
        try container.encode(name, forKey: .name)
        try container.encode(password, forKey: .password)
        try container.encode(email, forKey: .email)
        try container.encode(age, forKey: .age)
        try container.encode(sex, forKey: .sex)
        try container.encode(login, forKey: .login)
        if id != -1 {
            try container.encode(id, forKey: .id)
        }
        
    }
}
