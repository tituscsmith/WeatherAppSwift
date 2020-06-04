//
//  Forecast.swift
//  Weather
//
//  Created by Titus Smith on 6/2/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation

struct Forecast: Codable{
    var cod:String = ""
    var message:Int = 0
    var cnt:Int = 0
    var list:[ForecastList]
    init(){
        self.list = [ForecastList]()
    }
}
