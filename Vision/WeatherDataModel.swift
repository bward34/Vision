//
//  WeatherDataModel.swift
//  Vision
//
//  Created by Brandon Ward on 8/3/18.
//  Copyright © 2018 LEDBoyzz. All rights reserved.
//

import UIKit

class WeatherDataModel {

    var temperature : Int = 0
    var loTemp : Int = 0
    var hiTemp: Int = 0
    var conditionName : String = ""
    var city : String = ""
    var weatherIconName : String = ""
    var code: Int = 0
    
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
        case 0...4, 37, 38, 39, 45, 47 :
            return "thunderstorm"
        case 5...8, 35 :
            return "mix"
        case 9 :
            return "drizzle"
        case 10 :
            return "freezing_rain"
        case 11...12 :
            return "showers"
        case 13...16 :
            return "snow_showers"
        case 17...22 :
            return "foggy"
        case 23...24 :
            return "windy"
        case 25  :
            return "cold"
        case 26,44 :
            return "cloudy"
        case 27, 29 :
            return "cloudy_night"
        case 28, 30 :
            return "cloudy_day"
        case 31, 33 :
            return "clear_night"
        case 32, 34 :
            return "sunny"
        case 36 :
            return "hot"
        case 40:
            return "scattered_showers"
        case 41, 43:
            return "heavy_snow"
        case 42 :
            return "light_snow"
        case 46 :
            return "snow_showers"
        default :
            return "sunny"
        }
        
    }
}
