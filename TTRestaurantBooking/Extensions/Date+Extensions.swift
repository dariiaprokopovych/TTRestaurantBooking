//
//  Date+Extensions.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import Foundation

enum TimeFormat {
    case  date, time, dateTime
    
    func stringValue() -> String {
        switch self {
        case .date:
            return "dd MMMM yyyy"
        case .time:
                return "HH:mm"
        case .dateTime:
            return TimeFormat.date.stringValue() + ", " + TimeFormat.time.stringValue()
        }
    }
}

extension Date {
    func stringWithFormat(format: TimeFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.stringValue()
        dateFormatter.calendar = Calendar.current
        let result = dateFormatter.string(from: self)
        return result
    }
}
