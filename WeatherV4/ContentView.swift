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
    @ObservedObject var locationManager = LocationManager();
    @State private var imageName : String = "";
    
  //  @State private var imageName2 : String = "light-rain";
    init() {
        print(locationManager.getLat())
        print(locationManager.getLon())
        rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon())
        rd.getForecast(lat: locationManager.getLat(), lon: locationManager.getLon())
        imageName = "scattered-clouds"
        
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
         
            VStack(alignment: .center){
                HStack{
                    Text("Later: " + rd.getFutureTemp(hours: 0)); ForecastImage(imageName: self.$imageName)
                }
               
                HStack {
                    Text("Tomorrow: " + rd.getFutureTemp(hours:6))/*; ForecastImage(imageName2: self.$imageName2)*/
                }
                HStack {
                    Text("In Two Days: " + rd.getFutureTemp(hours: 14)); Image("scattered-clouds").resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                HStack {
                    Text("In Three Days: " + rd.getFutureTemp(hours: 22)); Image("scattered-clouds").resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                HStack {
                    Text("In Four Days: " + rd.getFutureTemp(hours: 30)); Image("scattered-clouds").resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                HStack {
                    Text("In Five Days: " + rd.getFutureTemp(hours: 38)); Image("scattered-clouds").resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                
            }.padding().font(.title)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
