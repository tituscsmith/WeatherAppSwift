//
//  RetrieveData.swift
//  WeatherV4
//
//  Created by Titus Smith on 6/3/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//

import Foundation
class RetrieveData{

    //figure out a way to have one variable/initializer
    var feels_like = 0.0;
    var wind_speed = 0.0;
    var description = "Blah";
    var main = "Blah";
    var name = "Blah";
    var f = Current();
    public func getJSON(lat: String, lon: String){
        print(lat)
        print(lon)
   // let urlString = //"https://api.openweathermap.org/data/2.5/weather?q=Madison,WI,USA&units=imperial&apikey=52ca258860cc9e61d80b63f12f04beba"
    let urlString =  "https://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lon+"&units=imperial&appid=52ca258860cc9e61d80b63f12f04beba"
   // let urlString =    "https://api.openweathermap.org/data/2.5/weather?lat=43.07&lon=-89.43&units=imperial&appid=52ca258860cc9e61d80b63f12f04beba"
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
        
                let forecast = try decoder.decode(Current.self, from: data!)
                print(forecast.main.feels_like)
                semaphore.signal()
                x = forecast.main.feels_like
                self.f = forecast
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
        return String(self.f.main.feels_like)
    }
    public func getWindSpeed() ->String{
        return String(self.f.wind.speed)
    }
    public func getMain()->String{
        return self.f.weather[0].main
    }
    public func getDescription()->String{
        return self.f.weather[0].description
    }
    public func getName()->String{
        return self.f.name
    }
    
}


