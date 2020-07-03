
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
    let count = 0...23;
    
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
        

            Spacer(minLength: 25)
            VStack{

                if(city != ""){Text(city).font(.largeTitle)}
               else{Text(originCity).font(.largeTitle)}
                
                Text(rd.getTemp()).font(.title)
                Text(rd.getDescription()).font(.subheadline)
            }
  
            HStack(alignment: .center){
                Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 0).temp.min)))).foregroundColor(.blue);
                Image(rd.getCurrentIcon()).resizable()
                .frame(width: 75, height: 75).clipShape(Circle())
                Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 0).temp.max)))).foregroundColor(.red);
                }.font(.title)

            ScrollView(.horizontal){
                Divider()
                HStack{
                    ForEach(0 ..< 23) { hour in
                        VStack {
                            Text(self.info.getReadableDate(timeStamp:self.rd.getHourly(hourNumber: hour).dt, exact: false, day: false));
                            Text(String(Int(round(self.rd.getHourly(hourNumber: hour).temp))));
                           // Divider()
                            Image(self.rd.getHourly(hourNumber: hour).weather[0].icon).resizable()
                                                     .frame(width: 50, height: 50).clipShape(Circle())
                             }.frame(width: 50)
                            // Divider()

                    }
                }
                Divider()
            }
                
            VStack{//(alignment: .leading)
                ForEach(1 ..< 6) { day in
                       HStack{
                        Text(self.info.getReadableDate(timeStamp:self.rd.getFutureTemp(dayNumber:day).dt, exact: false, day: true)).multilineTextAlignment(.leading).frame(width: 90)
                       //     Spacer()
                            VStack {
                                Text("Low: " + String(Int(round(self.rd.getFutureTemp(dayNumber: day).temp.min))))
                                Text("High: " + String(Int(round(self.rd.getFutureTemp(dayNumber: day).temp.max))));
                            }.frame(width: 80)
                        Image(self.rd.getFutureIcon(dayNumber:day)).resizable()
                                .frame(width: 50, height: 50).clipShape(Circle())
                               // Spacer()
                        Text(String(self.rd.getFutureTemp(dayNumber: day).weather[0].description)).frame(width: 100);

                        }
                }
            }/*.frame(alignment: .leading).padding(.horizontal)*/.font(.subheadline)

            Spacer(minLength: 40)
            Text("Scroll for more details\n").bold()
            Spacer(minLength: 10)
            
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        //Get exact time
                        Text("Sunrise: " + info.getReadableDate(timeStamp:rd.getCurrent().sys.sunrise, exact: true, day: false))
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
                        Text("Sunrise: " + info.getReadableDate(timeStamp:rd.getCurrent().sys.sunset, exact: true, day: false))
                        Spacer()
                        Text("Feels like: " + rd.getFeelsLike())
                        Spacer()
                        if(rd.getCurrent().visibility != nil){
                            Text("Visibility: " + String(rd.getCurrent().visibility ?? -1) + "m")
                        }
                    }
                }
                //Footer
                Text("\n\n\nTitus Smith - July 2020").italic()
                Text("Version 1.1.1").italic()
            }
//                         Text("\n\n\nTitus Smith - June 2020").italic()
//                         Text("Version 1.1.2").italic()
            
            
            //.italic()//.frame(alignment: .center)
    }.background(Color(red: 214 / 255, green: 252 / 255, blue: 255 / 255).edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
