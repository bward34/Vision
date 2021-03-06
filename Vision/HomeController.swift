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
import SwiftSocket

    var socket = WebSocket()

class HomeController: UIViewController, CLLocationManagerDelegate {

    let WEATHER_URL = "foo"
    let APP_ID = "bar"
    let YAHOO_ID = "foo"
    let YAHOO_URL = "bar"
    
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
    @IBOutlet var deviceLabel: UILabel!
    @IBOutlet var internetLabel: UILabel!
    @IBOutlet var ipAddress: UITextField!
    @IBOutlet var port: UITextField!
    @IBOutlet var infoPort: UILabel!
    
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
        
        ipAddress.text = "192.168.43.199"
        port.text = "23"
        
        self.pingChip()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Weather/Api logic functions
    
    //getData() -> gets the json data from api for weather/server
    func getData(url: String, parameters: [String: String], type: String) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in //specify self
            if response.result.isSuccess {
                self.internetLabel.text = "Connected!"
                self.internetLabel.textColor = UIColor.green
                let dataJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: dataJSON)
                
            }
            else {
                self.internetLabel.text = "Not Connected!"
                self.internetLabel.textColor = UIColor.red
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
                        self.getData(url: self.YAHOO_URL, parameters: yahoo_params, type: "weather")
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
    
    //updateIp() -> allows user to update the ip adress being sent to
    @IBAction func updateIP() {
        let ip:String = ipAddress.text!
        let portNum:String = port.text!
        socket.client = TCPClient(address: ip, port: Int32(portNum)!)
        infoPort.isHidden = false
        infoPort.text = "Checking network..."
        pingChip()
    }
    // MARK: Ping ESP8266 Chip
    // pingChip() -> A function for testing the connection with the ESP8266 Chip
    func pingChip() {
        if socket.transmitData(data: "ping") {
        deviceLabel.text = "Connected!"
        deviceLabel.textColor = UIColor.green
        }
        else {
        deviceLabel.text = "Not Connected!"
        deviceLabel.textColor = UIColor.red
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.infoPort.isHidden = true
        }
    }
    
}
