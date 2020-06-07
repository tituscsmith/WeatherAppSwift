
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
    @State private var city : String = ""
    private var originCity: String = ""
    let rd = RetrieveData();
    let info = DateTimeCompass();
    
    init() {
        //Make initial weather calls
        rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: self.showImperial, city: "")
        rd.getForecast(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: self.showImperial, city: "")
        originCity = rd.getName();
    }
    //Function called when city is changed; uses Dispatch queue for concurrency to ensure that
    //getForecast has the lat/lon from getCurrent since onecall doesn't work with just city names
    public func changeCity(cityString: String){

        let group = DispatchGroup()
         group.enter()
 
        // avoid deadlocks by not using .main queue here
        DispatchQueue.main.async {
           self.rd.getCurrent(lat: self.locationManager.getLat(), lon: self.locationManager.getLon(), isF: self.showImperial, city: cityString);
             group.leave()
        }
        group.notify(queue: .main) {
          //  print("Coords: " + String(self.rd.getCurrent().coord.lat) + " " + String(self.rd.getCurrent().coord.lon))
            self.rd.getForecast(lat: String(self.rd.getCurrent().coord.lat), lon: String(self.rd.getCurrent().coord.lon), isF: self.showImperial, city: cityString)
           // print("Coords after: " + String(self.rd.getFutureCoord().lat))
            self.city = cityString;//Update state after rd has been updated
        }
        return
    }
    
    //function called on toggle click for temperature scale
    public func changeScale(){
        //Imperial
        if (!self.showImperial /*&& count>2*/) {
            //print("Imperial = " + String(self.showImperial))
            rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: !self.showImperial, city: self.city)
            rd.getForecast(lat: String(rd.getCurrent().coord.lat), lon: String(rd.getCurrent().coord.lon), isF: !self.showImperial, city: self.city)
        }
            
        //Get Metric Data
        else if(self.showImperial){
            //print("Imperial = " + String(self.showImperial))
            self.rd.getCurrent(lat: self.locationManager.getLat(), lon: self.locationManager.getLon(), isF: !self.showImperial, city: self.city)
             self.rd.getForecast(lat: String(self.rd.getCurrent().coord.lat), lon: String(self.rd.getCurrent().coord.lon), isF: !self.showImperial, city: self.city)
        }
        
        return
    }
    
    var body: some View {
        
        //Check that location doesn't have an error
       // VStack(alignment: .center) {
        ScrollView(.vertical){
            
            HStack{
                Text("Change City (Hold)").italic().padding()
                .contextMenu {
                    Button(action: {
                        self.city = self.originCity;
                    }) {
                        Text("Original Location")
                    }
                    
                    Button(action: {
                        self.changeCity(cityString: "Ottawa")

                    }) {
                        Text("Ottawa")
                    }
                    Button(action: {
                        self.changeCity(cityString: "Chicago")

                    }) {
                        Text("Chicago")
                    }
                    Button(action: {
                        self.changeCity(cityString: "Paris")

                    }) {
                        Text("Paris")
                    }
                    Button(action: {
                        self.changeCity(cityString: "Beijing")

                    }) {
                        Text("Beijing")
                    }
                    Button(action: {
                        self.changeCity(cityString: "Sydney")

                    }) {
                        Text("Sydney")
                    }
                    Button(action: {
                        self.changeCity(cityString: "Seattle")
                    }) {
                        Text("Seattle")
                    }
                    Button(action: {
                        self.changeCity(cityString: "Houston")
                    }) {
                        Text("Houston")
                    }
                    Button(action: {
                        self.changeCity(cityString: "Miami")
                    }) {
                        Text("Miami")
                    }
                }
                //Picker or Search Bar?
                
            //Celcius
            Toggle(isOn: $showImperial) {
                Text("").font(.subheadline).padding()
                }.padding(.horizontal).onTapGesture {
                print("Temp has been toggled")
                self.changeScale()
                }//.frame(width: 125/*, alignment: .trailing*/)//.padding()//FIX ALIGNMENT
            }

            //Spacer()
            Spacer(minLength: 40)
            VStack{

                if(city != ""){Text(city).font(.largeTitle)}
               else{Text(originCity).font(.largeTitle)}
                
                Text(rd.getTemp()).font(.title)
                Text(rd.getDescription()).font(.subheadline)
            }
  
            HStack(alignment: .center, spacing: 10){
             //   Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 0).daily.te
                Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 0).temp.min)))).foregroundColor(.blue);
                Image(rd.getCurrentIcon()).resizable()
                .frame(width: 75, height: 75).clipShape(Circle())
                Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 0).temp.max)))).foregroundColor(.red);
                }.font(.title)
            
            
            //VStack(alignment: .center){
            ScrollView(.horizontal){//(alignment: .leading)
                
                HStack{
                        Text(info.getReadableDate(timeStamp:rd.getFutureTemp(dayNumber:1).dt)).multilineTextAlignment(.leading).frame(width: 90)
               //     Spacer()
                    VStack {
                        Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 1).temp.min))))
                        Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 1).temp.max))));
                    }.frame(width: 80)
                    Image(rd.getFutureIcon(dayNumber:1)).resizable()
                        .frame(width: 50, height: 50).clipShape(Circle())
                       // Spacer()
                        Text(String(rd.getFutureTemp(dayNumber: 1).weather[0].description)).frame(width: 100);
                    
                    if(rd.getFutureTemp(dayNumber: 1).rain != nil && rd.getFutureTemp(dayNumber: 1).rain! > 0.0){
                        Text(String(rd.getFutureTemp(dayNumber: 1).rain!) + "mm").frame(width: 100)
                    }
                    else{
                        Text("").frame(width: 100)
                    }
                }
                HStack {
                    Text(info.getReadableDate(timeStamp:rd.getFutureTemp(dayNumber:2).dt)).multilineTextAlignment(.leading).frame(width: 90)
                    //Spacer()
                    VStack {
                    Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 2).temp.min))))
                    Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 2).temp.max))));
                   }.frame(width: 80)
                      Image(rd.getFutureIcon(dayNumber:2)).resizable()
                                     .frame(width: 50, height: 50).clipShape(Circle())
                    Text(String(rd.getFutureTemp(dayNumber: 2).weather[0].description)).frame(width: 100);
                    
                    if(rd.getFutureTemp(dayNumber: 2).rain != nil && rd.getFutureTemp(dayNumber: 2).rain! > 0.0){
                        Text(String(rd.getFutureTemp(dayNumber: 2).rain!) + "mm").frame(width: 100)
                    }
                    else{
                        Text("").frame(width: 100)
                    }
                }
                HStack {
                    Text(info.getReadableDate(timeStamp:rd.getFutureTemp(dayNumber:3).dt)).multilineTextAlignment(.leading).frame(width: 90)
               //     Spacer()
                    VStack {
                        Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 3).temp.min))))
                        Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 3).temp.max))));
                    }.frame(width: 80)
                    Image(rd.getFutureIcon(dayNumber:3)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                    
                    Text(String(rd.getFutureTemp(dayNumber: 3).weather[0].description)).frame(width: 100);
                    
                    if(rd.getFutureTemp(dayNumber: 3).rain != nil && rd.getFutureTemp(dayNumber: 3).rain! > 0.0){
                        Text(String(rd.getFutureTemp(dayNumber: 3).rain!) + "mm").frame(width: 100)
                    }
                    else{
                        Text("").frame(width: 100)
                    }
   
                }
                HStack {
                    Text(info.getReadableDate(timeStamp:rd.getFutureTemp(dayNumber:4).dt)).multilineTextAlignment(.leading).frame(width: 90)
                  //  Spacer()
                   VStack {
                    Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 4).temp.min))))
                    Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 4).temp.max))));
                   }.frame(width: 80)
                    Image(rd.getFutureIcon(dayNumber:4)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                    
                    Text(String(rd.getFutureTemp(dayNumber: 4).weather[0].description)).frame(width: 100);
                    
                    if(rd.getFutureTemp(dayNumber: 4).rain != nil && rd.getFutureTemp(dayNumber: 4).rain! > 0.0){
                        Text(String(rd.getFutureTemp(dayNumber: 4).rain!) + "mm").frame(width: 100)
                    }
                    else{
                        Text("").frame(width: 100)
                    }
                }
                HStack {
               ///     Text("Five Days: ")
                    Text(info.getReadableDate(timeStamp:rd.getFutureTemp(dayNumber:5).dt)).multilineTextAlignment(.leading)
                    .frame(width: 90)
             //       Spacer()
                 VStack {
                    Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 5).temp.min))));
                    Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 5).temp.max))));
                 }.frame(width: 80)
                    Image(rd.getFutureIcon(dayNumber:5)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                    
                    Text(String(rd.getFutureTemp(dayNumber: 5).weather[0].description)).frame(width: 100);
                    
                    if(rd.getFutureTemp(dayNumber: 5).rain != nil && rd.getFutureTemp(dayNumber: 5).rain! > 0.0){
                        Text(String(rd.getFutureTemp(dayNumber: 5).rain!) + "mm").frame(width: 100)
                    }
                    else{
                        Text("").frame(width: 100)
                    }
                }
            }/*.frame(alignment: .leading).padding(.horizontal)*/.font(.subheadline)

            Spacer(minLength: 40)
            Text("Scroll for more details").italic()
            Spacer(minLength: 10)

            HStack{
                VStack(alignment: .leading){
                    Text("Sunrise: " + info.getReadableDate(timeStamp:rd.getCurrent().sys.sunrise))
                    Spacer()
                    Text("Humidity: " + String(rd.getHumidity()) + "%")
                    Spacer()
                    
                    //Wind in moth time units
                    if showImperial{
                        Text(info.compassDirection(heading: Double(rd.getWind().deg ?? -1)) + " " + String(rd.getWind().speed) + " mph")
                    }
                    else{
                        Text(info.compassDirection(heading: Double(rd.getWind().deg ?? -1)) + " " + String(rd.getWind().speed) + " kph")
                    }
                }
                VStack(alignment: .trailing){
                    Text("Sunrise: " + info.getReadableDate(timeStamp:rd.getCurrent().sys.sunset))
                    Spacer()
                    
                    Text("Visibility: " + String(rd.getCurrent().visibility ?? -1) + "m")
                    Spacer()
                    Text("Feels like: " + rd.getFeelsLike())
                }
            }
        }.background(Color(red: 214 / 255, green: 252 / 255, blue: 255 / 255).edgesIgnoringSafeArea(.all))
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
