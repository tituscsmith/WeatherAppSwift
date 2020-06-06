//
//  Sys.swift
//  Weather
//
//  Created by Titus Smith on 6/2/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation

struct Sys: Codable{
    var type:Int? = 0
    var id:Int? = 0
    var country:String? = ""
    var sunrise:Double = 0
    var sunset:Double = 0
    var pod:String? = ""
}
