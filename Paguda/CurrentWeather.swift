//
//  CurrentWeather.swift
//  Paguda
//
//  Created by Manolescu Mihai Alexandru on 23/02/2018.
//  Copyright © 2018 Manolescu Mihai Alexandru. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class WeatherSituation
{
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _description: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = "nil"
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = "nil"
        }
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
         self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = "nil"
        }
        return _weatherType
    }
    
    var description: String {
        if _description == nil {
            _description = "nil"
        }
        return _description
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    


    func downloadData(completed: @escaping DownloadComplete)
    {
        //Download with Alamofire
        let currentURL = URL(string: current_weather_url)!
        
        Alamofire.request(currentURL).responseJSON
       { response in
            let result = response.result
            print(response)
            
            if let dictionary = result.value as? Dictionary<String, AnyObject>
            {
                if let name = dictionary["name"] as? String
                {
          
                    self._cityName = name.capitalized
                    
                }
                
                if let weather = dictionary["weather"] as? [Dictionary<String, AnyObject>]
                {
                    
                    self._description = weather[0]["description"] as! String
                    self._weatherType = weather[0]["main"] as! String
                }
                
                if let main = dictionary["main"] as? Dictionary<String, AnyObject>
                {
                    if let currentTemperatureInKelvin = main["temp"] as? Double
                    {
                        var tempInCelsius = currentTemperatureInKelvin - 273.15
                        self._currentTemp = tempInCelsius
                    }
 
                }
                
                
                
                
            }
            completed()
        }
        
        
    }
    
}
