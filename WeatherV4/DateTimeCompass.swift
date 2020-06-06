//
//  DateTimeCompass.swift
//  WeatherV4
//
//  Created by Titus Smith on 6/6/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation

class DateTimeCompass{
    //https://medium.com/quick-code/easy-timestamp-to-readable-date-converter-5b93959a3cf9
    func getReadableDate(timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        } else if dateFallsInCurrentWeek(date: date) {
            if Calendar.current.isDateInToday(date) {
                dateFormatter.dateFormat = "h:mm a"
                return dateFormatter.string(from: date)
            } else {
                dateFormatter.dateFormat = "EEEE"
                return dateFormatter.string(from: date)
            }
        } else {
            dateFormatter.dateFormat = "MMM d"
            return dateFormatter.string(from: date)
        }
    }

    func dateFallsInCurrentWeek(date: Date) -> Bool {
        let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
        let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
        return (currentWeek == datesWeek)
    }
    //https://stackoverflow.com/questions/48118390/how-to-use-swift-to-convert-direction-degree-to-text
    func compassDirection(heading : Double) -> String {
        if heading < 0 { return "X" }
        print("Heading: " + String(heading))
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((heading + 22.5) / 45.0) & 7
        return directions[index]
    }
}
