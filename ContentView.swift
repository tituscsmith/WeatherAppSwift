
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
                Image(rd.getCurrentIcon()).resizable()
                                   .frame(width: 50, height: 50).clipShape(Circle())
            }.font(.title)
            Text(rd.getWindSpeed() + " mph winds")
            Text(rd.getDescription()).font(.subheadline)
            
            VStack(alignment: .center){
                HStack{
                   // Text("Later:" + rd.getCurrentIcon(dayNumber))
                    VStack {
                        Text("Low " + String(rd.getFutureTemp(dayNumber: 1).temp.min))
                        Text("High: " + String(rd.getFutureTemp(dayNumber: 1).temp.max));
                    }
                    
                    Image(rd.getFutureIcon(dayNumber:1)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
               
                HStack {
                   Text("Tomorrow:")
                   VStack {
                    
                    Text("Low " + String(rd.getFutureTemp(dayNumber: 2).temp.min))
                    Text("High: " + String(rd.getFutureTemp(dayNumber: 2).temp.max));
                   }
                      Image(rd.getFutureIcon(dayNumber:2)).resizable()
                                     .frame(width: 50, height: 50).clipShape(Circle())
                }
                HStack {
                    Text("Two Days:")
                    VStack {
                        Text("Low " + String(rd.getFutureTemp(dayNumber: 3).temp.min))
                        Text("High: " + String(rd.getFutureTemp(dayNumber: 3).temp.max));
                    }
                    Image(rd.getFutureIcon(dayNumber:3)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                HStack {
                   Text("Three Days:")
                   VStack {
                    Text("Low " + String(rd.getFutureTemp(dayNumber: 4).temp.min))
                    Text("High: " + String(rd.getFutureTemp(dayNumber: 4).temp.max));
                   }
                    Image(rd.getFutureIcon(dayNumber:4)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                HStack {
                 Text("Four Days:")
                 VStack {
                    Text("Low " + String(rd.getFutureTemp(dayNumber: 5).temp.min))
                    Text("High: " + String(rd.getFutureTemp(dayNumber: 5).temp.max));
                 }
                    Image(rd.getFutureIcon(dayNumber:5)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                HStack {
                 Text("Five Days:")
                 VStack {
                    Text("Low " + String(rd.getFutureTemp(dayNumber: 6).temp.min))
                    Text("High: " + String(rd.getFutureTemp(dayNumber: 6).temp.max));
                 }
                    Image(rd.getFutureIcon(dayNumber:6)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                }
                
            }.padding().font(.subheadline)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
