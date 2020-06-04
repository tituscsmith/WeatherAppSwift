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
    
    @ObservedObject var locationManager = LocationManager();
    let rd = RetrieveData();
    
  //  @State private var imageName2 : String = "light-rain";
    init() {
        print(locationManager.getLat())
        print(locationManager.getLon())
        rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon())
        rd.getForecast(lat: locationManager.getLat(), lon: locationManager.getLon())
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
                    Text("Later: " + rd.getFutureTemp(hours: 0));
                    Image(rd.getFutureForecast(hours:0)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
               
                HStack {
                    Text("Tomorrow: " + rd.getFutureTemp(hours:6));
                    Image(rd.getFutureForecast(hours:6)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                HStack {
                    Text("In Two Days: " + rd.getFutureTemp(hours: 14)); Image(rd.getFutureForecast(hours:14)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                HStack {
                    Text("In Three Days: " + rd.getFutureTemp(hours: 22)); Image(rd.getFutureForecast(hours:22)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                HStack {
                    Text("In Four Days: " + rd.getFutureTemp(hours: 30)); Image(rd.getFutureForecast(hours:30)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                HStack {
                    Text("In Five Days: " + rd.getFutureTemp(hours: 38)); Image(rd.getFutureForecast(hours:38)).resizable()
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
