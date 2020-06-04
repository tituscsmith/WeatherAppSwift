//
//  Main.swift
//  Weather
//
//  Created by Titus Smith on 6/2/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation

struct Main: Codable{
    var temp:Double? = 0
    var feels_like:Double = 0.0
    var temp_min:Double = 0
    var temp_max:Double = 0
    var pressure:Int? = 0
    var sea_level:Int? = 0
    var grnd_level:Int? = 0
    var humidity:Int? = 0
    var temp_kf:Double? = 0

}
