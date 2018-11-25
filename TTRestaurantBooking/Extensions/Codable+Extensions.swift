//
//  Codable+Extensions.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/25/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import Foundation

extension Decodable {
    init(from: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        self = try decoder.decode(Self.self, from: data)
    }
}
