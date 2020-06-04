//
//  ForecastList.swift
//  WeatherV4
//
//  Created by Titus Smith on 6/4/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation

struct ForecastList: Codable{
   var dt:Double = 0
   var main:Main
   var weather:[Weather]
    var clouds: Clouds
    var wind: Wind
    var sys: Sys
    var dt_text: String? = ""
    init(){
        self.main = Main()
        self.weather = [Weather]()
        self.clouds = Clouds()
        self.wind = Wind()
        self.sys = Sys()
    }
}
