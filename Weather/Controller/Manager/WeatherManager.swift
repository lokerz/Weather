//
//  WeatherManager.swift
//  Weather
//
//  Created by Ridwan Abdurrasyid on 23/01/20.
//  Copyright © 2020 ridwan. All rights reserved.
//

import Foundation
import MapKit
import Alamofire
import SwiftyJSON

class WeatherManager {    
    let key = "228260910b9ba5bc1d0cef47f4e6ced8"
    
    func getWeather(lat: Double, long: Double, completion: @escaping (_ weather : Weather) -> Void){        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(key)&units=metric").responseJSON { (response) in
            if let responseString = response.result.value {
                completion(self.JSONParser(responseString))
            }
        }
    }
    
    func getWeather(id: String, completion: @escaping (_ weather : Weather) -> Void){
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?id=\(id)&appid=\(key)&units=metric").responseJSON {
            (response) in
            if let responseString = response.result.value {
                completion(self.JSONParser(responseString))
            }
        }
    }
    
    func JSONParser(_ response : Any) -> Weather{
        let jsonResponse = JSON(response)
        if let jsonWeather = jsonResponse["weather"].array?.first {
            return Weather(
                cityName: jsonResponse["name"].stringValue,
                weatherName: jsonWeather["main"].stringValue,
                iconName: jsonWeather["icon"].stringValue,
                temperature: Int(round(jsonResponse["main"]["temp"].doubleValue))
            )
        }
        return Weather()
    }
}
