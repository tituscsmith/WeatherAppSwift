
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

/*class DateFormatter : Formatter{
    
}*/


struct ContentView: View {
    @ObservedObject var locationManager = LocationManager();
    @State private var showImperial = true
    @State private var city = ""
    @State private var searchText : String = ""
    @State private var hiddenTrigger = false
    @State private var name : String = ""
    @State private var current: Current?
   // @State private var selection = 1
    //let cities = ["London,UK", "Seattle,WA", "Detroit,MI"]
    let rd = RetrieveData();
  //  @State private var imageName2 : String = "light-rain";
    init() {
      //  current = Current()
        print(locationManager.getLat())
        print(locationManager.getLon())
        //rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon(), showImperial)
        //rd.getForecast(lat: locationManager.getLat(), lon: locationManager.getLon(), showImperial)
        rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: self.showImperial, city: "")
        
        rd.getForecast(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: self.showImperial, city: "")
    }
    
    //https://medium.com/quick-code/easy-timestamp-to-readable-date-converter-5b93959a3cf9
    func getReadableDate(timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        } else if dateFallsInCurrentWeek(date: date) {
            if Calendar.current.isDateInToday(date) {
                dateFormatter.dateFormat = "h:mm a"
                return dateFormatter.string(from: date)
            } else {
                dateFormatter.dateFormat = "EEEE"
                return dateFormatter.string(from: date)
            }
        } else {
            dateFormatter.dateFormat = "MMM d"
            return dateFormatter.string(from: date)
        }
    }

    func dateFallsInCurrentWeek(date: Date) -> Bool {
        let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
        let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
        return (currentWeek == datesWeek)
    }
    //https://stackoverflow.com/questions/48118390/how-to-use-swift-to-convert-direction-degree-to-text
    func compassDirection(heading : Double) -> String {
        if heading < 0 { return "" }
        print("Heading: " + String(heading))
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((heading + 22.5) / 45.0) & 7
        return directions[index]
    }
    public func changeCity(cityString: String){
        
        print("ChangeCityCalled" + cityString)
        
        
       /* rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: self.showImperial, city: cityString)

        rd.getForecast(lat: String(rd.getCurrent().coord.lat), lon: String(rd.getCurrent().coord.lon), isF: self.showImperial, city: "")*/
        let group = DispatchGroup()
         group.enter()
        print("ENDNAME3: " + self.rd.getCurrent().name)

        // avoid deadlocks by not using .main queue here
        DispatchQueue.main.async {
           self.rd.getCurrent(lat: self.locationManager.getLat(), lon: self.locationManager.getLon(), isF: self.showImperial, city: self.city);
        //    current = 5
  //          current.self = self.rd.getCurrent(lat: self.locationManager.getLat(), lon: self.locationManager.getLon(), isF: self.showImperial, city: self.city);
           // current self.rd.getCurrent()
            print("ENDNAME2: " + self.rd.getCurrent().name)
            group.leave()
        }
        group.notify(queue: .main) {
            self.rd.getForecast(lat: String(self.rd.getCurrent().coord.lat), lon: String(self.rd.getCurrent().coord.lon), isF: self.showImperial, city: self.city)
            print("ENDNAME1: " + self.rd.getCurrent().name)
        }
        print("ENDNAME: " + self.rd.getCurrent().name)
      //  hiddenTrigger = !hiddenTrigger
        return
    }
    public func changeScale(cityString: String) -> String{
        print("ChangeScaleCalled")
        //Imperial
        if (!self.showImperial /*&& count>2*/) {
            print("if")
            print("Imperial = " + String(self.showImperial))
       /*     rd.getCurrent(lat: locationManager.getLat(), lon: locationManager.getLon(), isF: !self.showImperial, city: cityString)
            print(rd.getCurrent().coord.lat)
            print(rd.getCurrent().coord.lon)
            rd.getForecast(lat: String(rd.getCurrent().coord.lat), lon: String(rd.getCurrent().coord.lon), isF: !self.showImperial, city: cityString)*/
        
            let group = DispatchGroup()
            group.enter()

           // avoid deadlocks by not using .main queue here
           DispatchQueue.main.async {
            self.rd.getCurrent(lat: self.locationManager.getLat(), lon: self.locationManager.getLon(), isF: !self.showImperial, city: self.city)

               group.leave()
           }
           group.notify(queue: .main) {
            self.rd.getForecast(lat: String(self.rd.getCurrent().coord.lat), lon: String(self.rd.getCurrent().coord.lon), isF: !self.showImperial, city: self.city)
           }
        }
            
        //Get Metric Data
        else if(self.showImperial){
            print("else")
            print("Imperial = " + String(self.showImperial))
            //Get opposite data
            let group = DispatchGroup()
            group.enter()

            // avoid deadlocks by not using .main queue here
            DispatchQueue.main.async {
                self.rd.getCurrent(lat: self.locationManager.getLat(), lon: self.locationManager.getLon(), isF: !self.showImperial, city: self.city)

                group.leave()
            }
            group.notify(queue: .main) {
                self.rd.getForecast(lat: String(self.rd.getCurrent().coord.lat), lon: String(self.rd.getCurrent().coord.lon), isF: !self.showImperial, city: self.city)
            }
            
           
        }
        else{return ""}
        return ""
    }
    
    var body: some View {
        
        //Check that location doesn't have an error
       // VStack(alignment: .center) {
        ScrollView(.vertical){
            
            HStack{
                Text("Change City (Hold)").padding()
                .contextMenu {
                    Button(action: {
                   //     print("\(self.hiddenTrigger ? "" : "")")
                        
                    //    self.changeScale();//Change it back to geolocation
                        self.city = "";
                        print("TESTOriginal")
                    }) {
                        Text("Original Location")
                    }
                    Button(action: {
                 //       print("\(self.hiddenTrigger ? "" : "")")
                        self.changeCity(cityString: "Chicago")
                        self.city = "Chicago";

                    }) {
                        Text("Chicago")
                    }
                    Button(action: {
  
                    }) {
                        Text("Seattle")
                    }
                }
                //Picker or Search Bar?
                
            //Celcius
            Toggle(isOn: $showImperial) {
                Text("").font(.subheadline).padding()
            }.padding(.horizontal).onTapGesture {
                print("Temp has been toggled")
                self.changeScale(cityString: "")
                }//.frame(width: 125/*, alignment: .trailing*/)//.padding()//FIX ALIGNMENT
            }

            //Spacer()
            Spacer(minLength: 40)
            VStack{
           //     Spacer(min100)
                Text(city).font(.largeTitle)
                Text(rd.getTemp()).font(.title)
                Text(rd.getDescription()).font(.subheadline)

            //    Text("Feels like: " + rd.getFeelsLike())
            }
  
            HStack(alignment: .center, spacing: 10){
                Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 0).temp.min)))).foregroundColor(.blue);
                Image(rd.getCurrentIcon()).resizable()
                .frame(width: 75, height: 75).clipShape(Circle())
                Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 0).temp.max)))).foregroundColor(.red);
                }.font(.title)
            
            
            //VStack(alignment: .center){
            ScrollView(.horizontal){//(alignment: .leading)
                HStack{
                   // Text("Tomorrow: ")Stacl{
                    VStack(alignment: .leading) {
                        Text(getReadableDate(timeStamp:rd.getFutureTemp(dayNumber:1).dt))
                    }
                    VStack {
                        //    Text("Titus")
                        Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 1).temp.min))))
                        Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 1).temp.max))));
                 //       Text(String(hiddenTrigger))
                    }
                    Image(rd.getFutureIcon(dayNumber:1)).resizable()
                        .frame(width: 50, height: 50).clipShape(Circle())
                       // Spacer()
                        Text(String(rd.getFutureTemp(dayNumber: 1).weather[0].description));
                    
                    if(rd.getFutureTemp(dayNumber: 1).rain != nil && rd.getFutureTemp(dayNumber: 1).rain! > 0.0){
                        Text(String(rd.getFutureTemp(dayNumber: 1).rain!) + "mm")
                    }
                }
                HStack {
                   // Text(getReadableData(timestamp: rd.getFutureTemp(dayNumber:2).dt))
               //     Text("Two Days Days: ")
                    Text(getReadableDate(timeStamp:rd.getFutureTemp(dayNumber:2).dt))
          //          Spacer()
                    VStack {
                    Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 2).temp.min))))
                    Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 2).temp.max))));
                   }
                      Image(rd.getFutureIcon(dayNumber:2)).resizable()
                                     .frame(width: 50, height: 50).clipShape(Circle())
                    Text(String(rd.getFutureTemp(dayNumber: 2).weather[0].description));
                    
                    if(rd.getFutureTemp(dayNumber: 2).rain != nil && rd.getFutureTemp(dayNumber: 2).rain! > 0.0){
                        Text(String(rd.getFutureTemp(dayNumber: 2).rain!) + "mm")
                    }
                }
                HStack {
                 //   Text("Three Days: ")
                    Text(getReadableDate(timeStamp:rd.getFutureTemp(dayNumber:3).dt))
               //     Spacer()
                    VStack {
                        Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 3).temp.min))))
                        Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 3).temp.max))));
                    }
                    Image(rd.getFutureIcon(dayNumber:3)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                    
                    Text(String(rd.getFutureTemp(dayNumber: 3).weather[0].description));
                    
                    if(rd.getFutureTemp(dayNumber: 3).rain != nil && rd.getFutureTemp(dayNumber: 3).rain! > 0.0){
                        Text(String(rd.getFutureTemp(dayNumber: 3).rain!) + "mm")
                    }
   
                }
                HStack {
               //     Text("Four Days: ")
                    Text(getReadableDate(timeStamp:rd.getFutureTemp(dayNumber:4).dt))
                  //  Spacer()
                   VStack {
                    Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 4).temp.min))))
                    Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 4).temp.max))));
                   }
                    Image(rd.getFutureIcon(dayNumber:4)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                    
                    Text(String(rd.getFutureTemp(dayNumber: 4).weather[0].description));
                    
                    if(rd.getFutureTemp(dayNumber: 4).rain != nil && rd.getFutureTemp(dayNumber: 4).rain! > 0.0){
                        Text(String(rd.getFutureTemp(dayNumber: 4).rain!) + "mm")
                    }
                }
                HStack {
               ///     Text("Five Days: ")
                    Text(getReadableDate(timeStamp:rd.getFutureTemp(dayNumber:5).dt))
             //       Spacer()
                 VStack {
                    Text("Low: " + String(Int(round(rd.getFutureTemp(dayNumber: 5).temp.min))));
                    Text("High: " + String(Int(round(rd.getFutureTemp(dayNumber: 5).temp.max))));
                 }
                    Image(rd.getFutureIcon(dayNumber:5)).resizable()
                    .frame(width: 50, height: 50).clipShape(Circle())
                    
                    Text(String(rd.getFutureTemp(dayNumber: 5).weather[0].description));
                    
                    if(rd.getFutureTemp(dayNumber: 5).rain != nil && rd.getFutureTemp(dayNumber: 5).rain! > 0.0){
                        Text(String(rd.getFutureTemp(dayNumber: 5).rain!) + "mm")
                    }
                }
            }/*.frame(alignment: .leading)*/.padding(.horizontal).font(.subheadline)//.frame(alignment: .leading)//.padding(.horizontal).font(.subheadline)
            
            
            
            Spacer(minLength: 40)
            Text("Scroll for more details")
            Spacer(minLength: 10)

            HStack{
                VStack(alignment: .leading){
                  //  Text("Sunrise: " + String(getDateFromTimeStamp(timeStamp: rd.getCurrent().sys.sunrise)))
                    Text("Sunrise: " + getReadableDate(timeStamp:rd.getCurrent().sys.sunrise))
                    Spacer()
                    Text("Humidity: " + String(rd.getHumidity()) + "%")
                    Spacer()
                    
                    //Wind
                    if !showImperial{
                     //   Text(rd.getWind().speed + " mph winds") }//ADD THE DIRECTION
                        Text(/*"Wind: " + */compassDirection(heading: Double(rd.getWind().deg)) + " " + String(rd.getWind().speed) + " mph")
                        
                    }
                    else{
                        Text(/*"Wind: " + */compassDirection(heading: Double(rd.getWind().deg)) + " " + String(rd.getWind().speed) + " kph")
                    }
                }
                VStack(alignment: .trailing){
             //       Text("Sunrise: " + String(getDateFromTimeStamp(timeStamp: rd.getCurrent().sys.sunset)))
                    Text("Sunrise: " + getReadableDate(timeStamp:rd.getCurrent().sys.sunset))
                    Spacer()
                    Text("Visibility: " + String(rd.getCurrent().visibility!) + "m")
                    Spacer()
                    Text("Feels like: " + rd.getFeelsLike())
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
