//
//  WeatherModel.swift
//  Weather
//
//  Created by Ridwan Abdurrasyid on 23/01/20.
//  Copyright © 2020 ridwan. All rights reserved.
//

import Foundation
import UIKit

struct Weather : Codable{
    let cityName : String?
    let weatherName : String?
    let iconName : String?
    let temperature : Int?
    
    init(
        cityName: String? = nil,
        weatherName : String? = nil,
        iconName : String? = "01d",
        temperature : Int? = nil
    ){
        self.cityName = cityName
        self.weatherName = weatherName
        self.iconName = iconName
        self.temperature = temperature
    }
}
