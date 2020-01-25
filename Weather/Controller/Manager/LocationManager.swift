//
//  LocationManager.swift
//  Weather
//
//  Created by Ridwan Abdurrasyid on 23/01/20.
//  Copyright © 2020 ridwan. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation


@objc protocol LocationDelegate {
    @objc optional func loadLocation()
}

let locationManager = LocationManager.instance

class LocationManager : NSObject, CLLocationManagerDelegate{
    static let instance = LocationManager()
    var delegate : LocationDelegate?
    
    var manager = CLLocationManager()
    var currentLocation: Location?
        
    func allowAccess(){
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }
    
    func checkCurrentLocation(){
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            setLocation(location : location)
            manager.stopUpdatingLocation()
        }
    }
    
    func setLocation(location : CLLocation){
        let geoCoder = CLGeocoder()

        geoCoder.reverseGeocodeLocation(location) { (arrayOfPlacemark, error) in
            guard let placemark = arrayOfPlacemark?.first else{ return }
            self.currentLocation = Location(
                detail: City(
                    id: placemark.isoCountryCode!,
                    name: placemark.locality!,
                    province: placemark.administrativeArea!,
                    country: placemark.country!
                ),
                coordinate: location.coordinate
            )
            self.delegate?.loadLocation?()
        }
    }
}
