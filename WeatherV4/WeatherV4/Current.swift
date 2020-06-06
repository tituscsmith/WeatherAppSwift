//
//  Forecast.swift
//  Weather
//
//  Created by Titus Smith on 6/2/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation

struct Current: Codable{
    var coord:Coords
    var weather:[Weather]
    var base:String = ""
    var main:Main
    var visibility:Int = 0
    var wind:Wind
    var clouds:Clouds
    var dt:Double = 0
    var sys:Sys
    var timezone:Double = 0
    var id:Int = 0
    var name:String = ""
    var cod:Int = 0

    init(){
        self.weather = [Weather]()
        self.coord = Coords()
        self.main = Main()
        self.wind = Wind()
        self.clouds = Clouds()
        self.sys = Sys()
    }
}
