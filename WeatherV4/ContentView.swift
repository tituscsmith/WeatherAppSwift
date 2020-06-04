//
//  ContentView.swift
//  WeatherV4
//
//  Created by Titus Smith on 6/2/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let rd = RetrieveData()
    init() {
        rd.getJSON()
    }
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text(rd.getName())
                Text(rd.getTemp() + "°F")
            }.font(.title)
            Text(rd.getWindSpeed() + " mph winds")
            Text(rd.getDescription()).font(.subheadline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
