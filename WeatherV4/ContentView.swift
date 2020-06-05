
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
    @State private var showImperial = true
    let rd = RetrieveData();
  //  @State private var imageName2 : String = "light-rain";
    init() {
        print(locationManager.getLat())
        print(locationManager.getLon())
        //rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon(), showImperial)
        //rd.getForecast(lat: locationManager.getLat(), lon: locationManager.getLon(), showImperial)
        rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: self.showImperial)
        rd.getForecast(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: self.showImperial)
    }
    
    public func changeScale() -> String{

        //Imperial
        if (!self.showImperial /*&& count>2*/) {
            print("if")
            print("Imperial = " + String(self.showImperial))
            rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: !self.showImperial)
            rd.getForecast(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: !self.showImperial)
            
        }
            
        //Get Metric Data
        else if(self.showImperial){
            print("else")
            print("Imperial = " + String(self.showImperial))
            //Get opposite data
            rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: !self.showImperial)
            rd.getForecast(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: !self.showImperial)
        }
        else{return ""}
        return ""
    }
    
    var body: some View {
        
        //Check that location doesn't have an error
       // VStack(alignment: .center) {
        ScrollView(.vertical){
        //    Spacer(minLength: 70)
            Text(rd.getName()).font(.largeTitle)
            Text(rd.getTemp()).font(.title)
            HStack(alignment: .center, spacing: 10){
                Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 0).temp.min)))).foregroundColor(.blue);
                Image(rd.getCurrentIcon()).resizable()
                .frame(width: 75, height: 75).clipShape(Circle())
                Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 0).temp.max)))).foregroundColor(.red);
                }.font(.title)
            if showImperial{
                Text(rd.getWindSpeed() + " mph winds")}
            else{
                Text(rd.getWindSpeed() + " kph winds")}
            Text(rd.getDescription()).font(.subheadline)
            
            //VStack(alignment: .center){
            ScrollView(.horizontal){
                HStack{
                    Text("Tomorrow:   ")
                    VStack {
                        Text("Low " + String(Int(round(rd.getFutureTemp(dayNumber: 1).temp.min))))
                        Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 1).temp.max))));
                    }
                    Image(rd.getFutureIcon(dayNumber:1)).resizable()
                        .frame(width: 50, height: 50).clipShape(Circle())
                       // Spacer()
                        Text(String(rd.getFutureTemp(dayNumber: 1).weather[0].description));
                        
                    
                }
               
                HStack {
                   Text("Two Days:   ")
                   VStack {
                    
                    Text("Low " + String(Int(round(rd.getFutureTemp(dayNumber: 2).temp.min))))
                    Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 2).temp.max))));
                   }
                      Image(rd.getFutureIcon(dayNumber:2)).resizable()
                                     .frame(width: 50, height: 50).clipShape(Circle())
                    Text(String(rd.getFutureTemp(dayNumber: 2).weather[0].description));

                }
                HStack {
                    Text("Three Days:")
                    VStack {
                        Text("Low " + String(Int(round(rd.getFutureTemp(dayNumber: 3).temp.min))))
                        Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 3).temp.max))));
                    }
                    Image(rd.getFutureIcon(dayNumber:3)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                    
                    Text(String(rd.getFutureTemp(dayNumber: 3).weather[0].description));

                }
                HStack {
                    Text("Four Days: ")

                   VStack {
                    Text("Low " + String(Int(round(rd.getFutureTemp(dayNumber: 4).temp.min))))
                    Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 4).temp.max))));
                   }
                    Image(rd.getFutureIcon(dayNumber:4)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                    
                    Text(String(rd.getFutureTemp(dayNumber: 4).weather[0].description));
                }
                HStack {
                    Text("Five Days:  ")

                 VStack {
                    Text("Low " + String(Int(round(rd.getFutureTemp(dayNumber: 5).temp.min))));
                    Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 5).temp.max))));
                 }
                    Image(rd.getFutureIcon(dayNumber:5)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                    
                    Text(String(rd.getFutureTemp(dayNumber: 5).weather[0].description));

                }
            }.padding().font(.subheadline)
            
            Toggle(isOn: $showImperial) {
                Text("Fahrenheit")
                }.frame(width: 150).padding()
            if showImperial {
                //Fake text methods to change the scales
                Text("\(self.changeScale())").hidden().frame(width: 0, height: 0)
            }
            else{
                Text("\(self.changeScale())").hidden().frame(width: 0, height: 0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
