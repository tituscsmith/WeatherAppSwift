//
//  RetrieveData.swift
//  WeatherV4
//
//  Created by Titus Smith on 6/3/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation
import SwiftUI

class RetrieveData{

    //figure out a way to have one variable/initializer

    let key = "52ca258860cc9e61d80b63f12f04beba"

    var c = Current();
    var f = Forecast();
    var d = DailyForecast();
    var h = HourlyForecast();
    var o = Onecall();
  //  var state: Bool = false;
    public func getCurrent(lat: String, lon: String, isF: Bool, city: String){
        var urlString:String = ""
        print("getting current");

        //Check the units
        var units = "imperial"
        if(!isF){
            units = "metric"
        }
        
        if(city == ""){
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lon+"&units=" + units + "&appid=" + key
        }
        else{
             urlString =  "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&units=" + units + "&appid=" + key
        }
        print("getCurrent called" + city)
        
    //Make JSON call
    let url = URL(string: urlString)
    guard url != nil else{
        return
    }
    
    let session = URLSession.shared
    let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
    let dataTask = session.dataTask(with: url!){
        (data, response ,error) in
        
        //Check for errors
        if error == nil && data != nil {
            let decoder = JSONDecoder()
            do{
        
                let current = try decoder.decode(Current.self, from: data!)
                semaphore.signal()
                self.c = current
            }
            catch let jsonError{
                print(jsonError)
            }
        }
        
    }
    
    dataTask.resume()
    semaphore.wait()//wait for networking session
}
    public func getForecast(lat: String, lon: String, isF: Bool, city: String){
       var urlString:String = ""
       print("getting forecase");

        //check temperature units
        var units = "imperial"
        if(!isF){
            units = "metric"
        }

        urlString =  "https://api.openweathermap.org/data/2.5/onecall?lat="+lat+"&lon="+lon+"&units=" + units + "&appid=" + key
       // print(urlString)

        print("getForeCast called" + lat + " " + lon)


        let url = URL(string: urlString)
        
        guard url != nil else{
            return
        }
        
        //Make JSON call
        let session = URLSession.shared
        let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
        let dataTask = session.dataTask(with: url!){
            (data, response ,error) in
            
            //Check for errors
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
//                    let dailyForecast = try decoder.decode(DailyForecast.self, from: data!)
//                    self.d = dailyForecast
                    let onecall = try decoder.decode(Onecall.self, from: data!)
                    self.o = onecall
                    semaphore.signal()
                }
                catch let jsonError{
                    print(jsonError)
                }
            }
            
        }
        
        dataTask.resume()
        semaphore.wait()//wait for networking session
    }
    public func getTemp() ->String{
        return String(self.c.main.temp)
    }
    public func getFeelsLike() ->String{
        return String(self.c.main.feels_like)
    }
    public func getWind() -> Wind{
        return self.c.wind
    }
    public func getHumidity() ->String{
        return String(self.c.main.humidity)
    }
    public func getMain()->String{
        return self.c.weather[0].main
    }
    public func getCurrent()->Current{
     //   print("City: " + self.c.name)
        return self.c
    }
    public func getDescription()->String{
        return self.c.weather[0].description
    }
    public func getName()->String{
        return self.c.name
    }
    public func getCurrentIcon()->String{
        return self.c.weather[0].icon
    }
    public func getFutureTemp(dayNumber:Int)->DailyForecast{
        return self.o.daily[dayNumber];
    }
    public func getFuture()->Onecall{
        return self.o
    }
 
//    public func getFutureIcon(dayNumber: Int)->String{
//        return self.d.daily[dayNumber].weather[0].icon
//    }
//
    public func getFutureIcon(dayNumber: Int)->String{
        return self.o.daily[dayNumber].weather[0].icon;
    }
    public func getHourly(hourNumber: Int)->HourlyForecast{
        //   print("City: " + self.c.name)
        return self.o.hourly[hourNumber];
       // self.o.hourly.hour
       }
}
