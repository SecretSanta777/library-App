//
//  DateFormatterExt.swift
//  Library App
//
//  Created by Владимир Царь on 28.10.2025.
//

import Foundation

extension Date {
    var dayNumber: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
