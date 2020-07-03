//
//  HourlyForecast.swift
//  WeatherV4
//
//  Created by Titus Smith on 7/3/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation

struct HourlyForecast: Codable{
    var dt:Double = 0
    var temp:Double = 0
    var feels_like:Double = 0
    var pressure:Int? = 0
    var humidity:Int? = 0
    var dew_point:Double? = 0
    var clouds:Int = 0
    var wind_speed:Double? = 0
    var wind_deg:Double? = 0
    var weather:[Weather]
    //var rain:String?
    
    init(){
        self.weather = [Weather]()
        print("NEED TO FIX RAIN FOR ARRAY");
    }
}
