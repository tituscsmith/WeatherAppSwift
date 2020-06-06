//
//  DailyForecast.swift
//  WeatherV4
//
//  Created by Titus Smith on 6/4/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation

struct Daily: Codable{
    var dt:Double = 0
    var sunrise:Int? = 0
    var sunset:Int? = 0
    var temp:Temp
    var feels_like:FeelsLike
    var pressure:Int? = 0
    var humidity:Int? = 0
    var dew_point:Double? = 0
    var wind_speed:Double? = 0
    var wind_deg:Double? = 0
    var weather:[Weather]
    var clouds:Int = 0
    var rain:Double? = 0
    var uvi:Double? = 0
    
    init(){
        self.weather = [Weather]()
        self.temp = Temp()
        self.feels_like = FeelsLike()        
    }
}
