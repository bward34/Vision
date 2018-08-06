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
    let YAHOO_ID = "bCKyRS44"
    let YAHOO_URL = "https://query.yahooapis.com/v1/public/yql"
    
    let locationManager = CLLocationManager()
    let weatherData = WeatherDataModel();
    
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    //MARK: Weather container
    @IBOutlet var weatherView: UIView!
    @IBOutlet var cityLabel : UILabel!
    @IBOutlet var tempLabel : UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var condtion: UILabel!
    @IBOutlet var loTemp: UILabel!
    @IBOutlet var hiTemp: UILabel!
    
    //MARK: System info container
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the current date and time
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        dateLabel.text = "\(currentDateString)"
        
        //get current time to determine the greeting
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        switch(hour) {
            case 1...12 :
                greetingLabel.text = "Good morning"
            case 12...17 :
                greetingLabel.text = "Good afternoon"
            case 17...20 :
                greetingLabel.text = "Good evening"
            case 20...24 :
                greetingLabel.text = "Good night"
            default:
                greetingLabel.text = "Good day"
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Weather logic functions
    
    //getWeatherData() -> gets the json data from api for weather
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in //specify self
            if response.result.isSuccess {
                let weatherJSON : JSON = JSON(response.result.value!)
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
            
            //gets the location city and state to query the api
            CLGeocoder().reverseGeocodeLocation(location) { (placemark, error ) in
                if error != nil {
                    self.cityLabel.text = "Error"
                }
                else {
                    if let place = placemark?[0] {
                        let state = place.administrativeArea!
                        let city = place.locality!
                        let query = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\u{22}\(city.lowercased()), \(state.lowercased())\u{22})"
                        let yahoo_params : [String : String ] = ["q": query, "format" : "json"]
                       self.getWeatherData(url: self.YAHOO_URL, parameters: yahoo_params)
                    }
                }
            }
        }
    }
    
    //locationManager() -> delegate to handle error when updating location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    //updateWeatherData() -> parses the json data to weather model object.
    func updateWeatherData(json : JSON) {
        if Int(json["query"]["results"]["channel"]["item"]["condition"]["temp"].stringValue) != nil {
        //converts temp to c to f
        weatherData.temperature  = Int(json["query"]["results"]["channel"]["item"]["condition"]["temp"].stringValue)!
        weatherData.loTemp  = Int(json["query"]["results"]["channel"]["item"]["forecast"][0]["low"].stringValue)!
        weatherData.hiTemp  = Int(json["query"]["results"]["channel"]["item"]["forecast"][0]["high"].stringValue)!
        let stateName = json["query"]["results"]["channel"]["location"]["region"].stringValue
        let cityName = json["query"]["results"]["channel"]["location"]["city"].stringValue
        weatherData.city = "\(cityName), \(stateName)"
        weatherData.conditionName = json["query"]["results"]["channel"]["item"]["condition"]["text"].stringValue
        weatherData.code = Int(json["query"]["results"]["channel"]["item"]["condition"]["code"].stringValue)!
        weatherData.weatherIconName = weatherData.updateWeatherIcon(condition: weatherData.code)
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
    
    // MARK: END Weather logic functions
}
