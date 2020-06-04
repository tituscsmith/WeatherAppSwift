//
//  ForecastDisplay.swift
//  WeatherV4
//
//  Created by Titus Smith on 6/3/20.
//  Copyright © 2020 Titus Smith. All rights reserved.
//




//THIS CLASS IS OUTDATED NOW
























import SwiftUI

struct ForecastDisplay: View {
    var body: some View {
        Text(getJSON())
    }
}

struct ForecastDisplay_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDisplay()
    }
}

var x = 0.0;
struct tempResponse {
    var feels_like = 0.0
}
public func getJSON() -> String{
    var r = tempResponse()

    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Dane&units=imperial&apikey=52ca258860cc9e61d80b63f12f04beba"
    let url = URL(string: urlString)
    
    guard url != nil else{
        return "blah"
    }
    
    let session = URLSession.shared
    let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore
    let dataTask = session.dataTask(with: url!){
        (data, response ,error) in
        
        //Check for errors
        if error == nil && data != nil {
            let decoder = JSONDecoder()
            do{
        
                let forecast = try decoder.decode(Forecast.self, from: data!)
                print(forecast.main.feels_like)
                semaphore.signal()
                x = forecast.main.feels_like
                r.feels_like = forecast.main.feels_like
   
            }
            catch let jsonError{
                print(jsonError)
            }
        }
        
    }
    
    dataTask.resume()
    semaphore.wait()//wait for networking session
    return String(r.feels_like)
    //return String(x)
}
