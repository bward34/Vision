//
//  HomeController.swift
//  Vision
//
//  Created by Brandon Ward on 7/31/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreData
import SwiftyJSON
import Alamofire

class HomeController: UIViewController, CLLocationManagerDelegate {

    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "30c2075ee7aed4c338fa76abed5e1b3c"
    
    let locationManager = CLLocationManager()
    let weatherData = WeatherDataModel();
    
    @IBOutlet var cityLabel : UILabel!
    @IBOutlet var tempLabel : UILabel!
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var condtion: UILabel!
    @IBOutlet var loTemp: UILabel!
    @IBOutlet var hiTemp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //getWeatherData() -> gets the json data from api for weather
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in //specify self
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    //locationManager() -> delegate function for checking if location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            self.locationManager.stopUpdatingLocation()
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    //locationManager() -> delegate to handle error when updating location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    //updateWeatherData() -> parses the json data to weather model object.
    func updateWeatherData(json : JSON) {
        if let tempResult = json["main"]["temp"].double {
        //converts temp to c to f
        weatherData.temperature  = Int(((json["main"]["temp"].double! - 273.15) * (1.8)) + 32)
        weatherData.loTemp  = Int(((json["main"]["temp_min"].double! - 273.15) * (1.8)) + 32)
        weatherData.hiTemp  = Int(((json["main"]["temp_max"].double! - 273.15) * (1.8)) + 32)
        weatherData.city = (json["name"].stringValue).uppercased()
        weatherData.conditionName = (json["weather"][0]["main"].stringValue).uppercased()
        weatherData.condition = json["weather"][0]["id"].intValue
        weatherData.weatherIconName = weatherData.updateWeatherIcon(condition: weatherData.condition)
        updateUIWithWeatherData()
        }
        else {
            cityLabel.text = "Weather Unavailable"
        }
    }
    
    //updateUIWithWeatherData() -> updated the view with the correct weather data
    func updateUIWithWeatherData() {
        cityLabel.text = weatherData.city
        loTemp.text = "LO: \(weatherData.loTemp)°"
        hiTemp.text = "HI: \(weatherData.hiTemp)°"
        tempLabel.text = "\(weatherData.temperature)°"
        condtion.text = weatherData.conditionName
        weatherImage.image = UIImage(named: weatherData.weatherIconName)
    }
}
