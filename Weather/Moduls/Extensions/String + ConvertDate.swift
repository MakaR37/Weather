//
//  Extensions.swift
//  Weather
//
//  Created by Артем Мак on 22.02.2022.
//  Copyright © 2022 Артем Мак. All rights reserved.
//

import Foundation

extension String {
    mutating func convertDateSince1970(date: Int, formatDate: String, locale: String)  {
        let date = Date(timeIntervalSince1970: Double(date))
        let dateFormat = formatDate
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateFormat
        dayTimePeriodFormatter.locale = Locale(identifier: locale)
        
        let dateString = dayTimePeriodFormatter.string(from: date)
        let currentDateString = dayTimePeriodFormatter.string(from: Date())
        
        if currentDateString == dateString {
            if dateFormat == "hh" {
                self = "Сейчас"
            } else if dateFormat == "E" {
                self = "Ceгодня"
            }
        } else {
            self = dateString.capitalized
        }
    }
}
