//
//  ContentView.swift
//  WeatherV4
//
//  Created by Titus Smith on 6/2/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    let rd = RetrieveData();
    @ObservedObject var locationManager = LocationManager()

    init() {
        print(locationManager.getLat())
        print(locationManager.getLon())
        rd.getJSON(lat: locationManager.getLat(), lon: locationManager.getLon())
    }
    
    var body: some View {
        //Check that location doesn't have an error
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
