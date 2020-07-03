//
//  Onecall.swift
//  WeatherV4
//
//  Created by Titus Smith on 7/3/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation


import Foundation
//For the One Call API
struct Onecall: Codable{
    var lat:Double = 0.0
    var lon:Double = 0.0
    var timezone:String? = ""
    var timezone_offset: Int? = 0
    var hourly:[HourlyForecast]
    var daily:[DailyForecast]
    init(){
        self.daily = [DailyForecast]()
        self.hourly = [HourlyForecast]()
       }
}
