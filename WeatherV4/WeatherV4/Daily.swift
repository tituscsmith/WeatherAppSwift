//
//  Daily.swift
//  WeatherV4
//
//  Created by Titus Smith on 6/4/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation
//For the One Call API
struct DailyForecast: Codable{
    var lat:Double? = 0
    var lon:Double = 0.0
    var timezone:String = ""
    var timezone_offset: Int = 0
    var daily:[Daily]
    init(){
           self.daily = [Daily]()
           
       }
}
