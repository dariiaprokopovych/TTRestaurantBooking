//
//  Date+Extensions.swift
//  TTRestaurantBooking
//
//  Created by Dariya on 11/24/18.
//  Copyright © 2018 dariyaprokopovych. All rights reserved.
//

import Foundation

enum TimeFormat {
    case  date, time, dateTime, fullWithoutSeconds, fullFormatDate
    
    func stringValue() -> String {
        switch self {
        case .date:
            return "dd MMMM yyyy"
        case .time:
                return "HH:mm"
        case .fullFormatDate:
            return "yyyy-MM-dd'T'HH:mm:ss.SSS"
        case .fullWithoutSeconds:
            return "yyyy-MM-dd'T'HH:mm:ss"
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
    
    static func combine(date: Date, hours: Date) -> Date {
        var dateComponents = Calendar.current.dateComponents([.day, .year, .month], from: date)
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: hours)
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute
        let finalDate = Calendar.current.date(from: dateComponents)
        return finalDate ?? Date()
    }
}

extension String {
    func date(format: TimeFormat) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.stringValue()
        dateFormatter.calendar = Calendar.current
        return dateFormatter.date(from: self) ?? Date()
    }
}
