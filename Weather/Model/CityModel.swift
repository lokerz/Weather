//
//  CityModel.swift
//  Weather
//
//  Created by Ridwan Abdurrasyid on 23/01/20.
//  Copyright © 2020 ridwan. All rights reserved.
//

import Foundation
import CoreLocation

struct City : Codable, Equatable{
    let id : String
    let name : String
    let province : String
    let country : String
    
    func contains(_ str : String) -> Bool{
        let city = name + province + country
        return city.lowercased().contains(str)
    }
}

struct Location {
    let detail : City
    let coordinate : CLLocationCoordinate2D
}
