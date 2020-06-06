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
    var feels_like = 0.0;
    var wind_speed = 0.0;
    var description = "Blah";
    var main = "Blah";
    var name = "Blah";
    var c = Current();
    var f = Forecast();
    var d = DailyForecast();
  //  var state: Bool = false;
    public func getCurrent(lat: String, lon: String, isF: Bool, city: String){
        var urlString:String = ""
        print("Retrieving forecast for" + city)
        if(city == ""){
            
            if(isF){
                urlString =  "https://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lon+"&units=imperial&appid=52ca258860cc9e61d80b63f12f04beba"
            }
            else{
                urlString =  "https://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lon+"&units=metric&appid=52ca258860cc9e61d80b63f12f04beba"
            }
        }
        else{

            if(isF){
                urlString =  "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&units=imperial&appid=52ca258860cc9e61d80b63f12f04beba"
            }
            else{
                urlString =  "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&units=metric&appid=52ca258860cc9e61d80b63f12f04beba"
            }

        }
        
      //  state = isF
        print("getCurrent called" + city)
        
        
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
                print(current.main.feels_like)
                semaphore.signal()
           //     x = current.main.feels_like
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
     //  if(city == ""){
        print("Retrieving forecast for" + lat + " " + lon)
           if(isF){
            
               urlString =  "https://api.openweathermap.org/data/2.5/onecall?lat="+lat+"&lon="+lon+"&units=imperial&appid=52ca258860cc9e61d80b63f12f04beba"
           }
           else{
               urlString =  "https://api.openweathermap.org/data/2.5/onecall?lat="+lat+"&lon="+lon+"&units=metric&appid=52ca258860cc9e61d80b63f12f04beba"
           }
     //  }
   /*    else{
           if(isF){
               urlString =  "https://api.openweathermap.org/data/2.5/onecall?q=" + city + "&units=imperial&appid=52ca258860cc9e61d80b63f12f04beba"
           }
           else{
               urlString =  "https://api.openweathermap.org/data/2.5/onecall?q=" + city + "&units=metric&appid=52ca258860cc9e61d80b63f12f04beba"
           }
       }*/
        print("getForeCast called" + lat + " " + lon)

        //For five day forecast

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
            
                    //let forecast = try decoder.decode(Forecast.self, from: data!)
                 //   print(forecast.main.feels_like)
                    let dailyForecast = try decoder.decode(DailyForecast.self, from: data!)
                    self.d = dailyForecast
                    semaphore.signal()
                  //  self.f = forecast
                    
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
      //  return self.d.daily[0].weather[0].description
        return self.c.weather[0].description
    }
    public func getName()->String{
        return self.c.name
    }
    public func getCurrentIcon()->String{
        return self.c.weather[0].icon
    }
    public func getFutureTemp(dayNumber:Int)->Daily{
     /*   if(self.d.daily===nil){
            return 0
        }*/
       // return self.d.daily[dayNumber];
        return self.d.daily[dayNumber];
    }
    public func getFutureCoord()->DailyForecast{
        return self.d
    }
    public func getFutureIcon(dayNumber: Int)->String{
        return self.d.daily[dayNumber].weather[0].icon
    }
   /* public func getFutureTemp(hours: Int)->Main{
        return self.f.list[hours].main;
    }
    public func getFutureForecast(hours: Int)->String{
        print(self.f.list[hours].weather[0].icon)
        return self.f.list[hours].weather[0].icon;
    }*/
    
    
}
