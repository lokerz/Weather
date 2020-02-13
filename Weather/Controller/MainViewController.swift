//
//  ViewController.swift
//  Weather
//
//  Created by Ridwan Abdurrasyid on 23/01/20.
//  Copyright © 2020 ridwan. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class MainViewController: UIViewController {
    
    var currentCity : City?
    var isUsingCurrentLocation = true
    var gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var weatherImageOutlet: UIImageView!
    @IBOutlet weak var weatherCountryLabelOutlet: UILabel!
    @IBOutlet weak var weatherStatusLabelOutlet: UILabel!
    @IBOutlet weak var weatherTemperatureLabelOutlet: UILabel!
    @IBOutlet weak var loadingIndicatorOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupManager()
        setupBackground()
        setupLoadingIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupOfflineData()
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        }
    }
    
    func setupManager(){
        locationManager.allowAccess()
        locationManager.checkCurrentLocation()
        locationManager.delegate = self
    }
    
    func setupLoadingIndicator(){
        loadingIndicatorOutlet.rotate()
    }
    
    func setupOfflineData(){
        guard let networkManager = NetworkReachabilityManager() else {return}
        if !networkManager.isReachable {
            let city = DataManager().loadCity()
            let weather = DataManager().loadWeather()
            navigationItem.title = weather.cityName
            weatherImageOutlet.weatherImage(iconName: weather.iconName!)
            weatherStatusLabelOutlet.text = weather.weatherName
            weatherTemperatureLabelOutlet.text = String(weather.temperature ?? 0)
            weatherCountryLabelOutlet.text = city.province + ", " + city.country + " (Offline)"
            setupBackgroundColor(time: weather.iconName!)
        }
    }
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        loadingIndicatorOutlet.isHidden = false
        if isUsingCurrentLocation {
            if let coord = locationManager.currentLocation?.coordinate {
                getWeather(coordinate : coord)
            }
        } else {
            getWeather(id: currentCity!.id)
        }
    }
    
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue){
        refreshButtonAction(self)
    }
    
    @IBAction func unwindCurrentLocation(segue : UIStoryboardSegue){
        refreshButtonAction(self)
    }
    
    func getWeather(coordinate : CLLocationCoordinate2D){
        WeatherManager().getWeather(lat: coordinate.latitude, long: coordinate.longitude){
            (weather) in self.setWeather(weather: weather)
        }
    }
    
    func getWeather(id : String){
        WeatherManager().getWeather(id: id){
            (weather) in self.setWeather(weather: weather)
        }
    }
    
    func setWeather(weather : Weather) {
        navigationItem.title = weather.cityName
        weatherImageOutlet.weatherImage(iconName: weather.iconName!)
        weatherStatusLabelOutlet.text = weather.weatherName
        weatherTemperatureLabelOutlet.text = String(weather.temperature!)
        if !isUsingCurrentLocation {
            weatherCountryLabelOutlet.text = currentCity!.province + ", " + currentCity!.country
        } else {
            weatherCountryLabelOutlet.text = locationManager.currentLocation!.detail.province + ", " + locationManager.currentLocation!.detail.country
            DataManager().saveData(city: locationManager.currentLocation!.detail, weather: weather)
        }
        setupBackgroundColor(time: weather.iconName!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.loadingIndicatorOutlet.isHidden = true
        }
    }
}

extension MainViewController : LocationDelegate{
    func loadLocation() {
        guard let coord = locationManager.currentLocation?.coordinate else {return}
        getWeather(coordinate: coord)
    }
}

