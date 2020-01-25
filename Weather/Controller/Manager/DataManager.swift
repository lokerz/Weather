//
//  DataManager.swift
//  Weather
//
//  Created by Ridwan Abdurrasyid on 24/01/20.
//  Copyright © 2020 ridwan. All rights reserved.
//

import Foundation

class DataManager{
    let database = UserDefaults.standard
    
    func saveData(city: City, weather: Weather){
        database.set(try? JSONEncoder().encode(city), forKey: "city" )
        database.set(try? JSONEncoder().encode(weather), forKey: "weather")
        database.synchronize()
    }
    
    func loadWeather() -> Weather{
        var weather = Weather()
        database.register(defaults: ["weather" : try? JSONEncoder().encode(weather)])
        if let data = database.value(forKey: "weather") as? Data{
            if let temp = try? JSONDecoder().decode(Weather.self, from: data) {
                weather = temp
            }
        }
        return weather
    }
    
    func loadCity() -> City{
        var city = City(id: "0", name: "Jakarta Pusat", province: "Jakarta", country: "Indonesia")
        database.register(defaults: ["city" : try? JSONEncoder().encode(city)])
        if let data = database.value(forKey: "city") as? Data{
            if let temp = try? JSONDecoder().decode(City.self, from: data) {
                city = temp
            }
        }
        return city
    }
}
