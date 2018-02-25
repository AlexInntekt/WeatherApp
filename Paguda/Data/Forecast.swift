//
//  Forecast.swift
//  Paguda
//
//  Created by Manolescu Mihai Alexandru on 25/02/2018.
//  Copyright © 2018 Manolescu Mihai Alexandru. All rights reserved.
//

import Foundation
import Alamofire

class Forecast
{

    var _date: String!
    var _weatherType: String!
    var _description: String!
    var _minTemp: Double!
    var _maxTemp: Double!
    
    
    var date: String
    {
        if _date == nil
        {
            _date = "nil"
        }

        self._date = "YYYY-MM-DD"
        
        return _date
    }
    
    var weatherType: String
    {
        if _weatherType == nil
        {
            _weatherType = "nil"
        }
        return _weatherType
    }
    
    var description: String
    {
        if _description == nil
        {
            _description = "nil"
        }
        return _description
    }
    
    var minTemp: Double
    {
        if _minTemp == nil
        {
            _minTemp = 0.0
        }
        return _minTemp
    }
    
    var maxTemp: Double
    {
        if _maxTemp == nil
        {
            _maxTemp = 0.0
        }
        return _maxTemp
    }

    
    
    func downloadDataForForecast(for specificURL: String,completed: @escaping DownloadComplete)
    {
        //Download with Alamofire
        let currentURL = URL(string: specificURL)!
        
        print("IDENTIFIER9304gh3094g URL for forecast:", currentURL)
        
        Alamofire.request(currentURL).responseJSON
            { response in
                let result = response.result
                print(response)
                
                if let dictionary = result.value as? Dictionary<String, AnyObject>
                {
                    
                    if let list = dictionary["list"] as? [Dictionary<String, AnyObject>]
                    {
                        for object in list
                        {
                            
                            self._date = object["dt_txt"] as! String
                            
                            
                            if let min = object["main"]!["temp_min"] as? Double
                            {
                                self._minTemp = convertKelvinToCelsius(min)
                            }
                            
                            if let max = object["main"]!["temp_max"] as? Double
                            {
                                self._maxTemp = convertKelvinToCelsius(max)
                            }
                    
                            if let itsWeatherData = object["weather"] as! [Dictionary<String,AnyObject>]!
                            {
                                self._description = itsWeatherData[0]["main"] as! String
                            }
                            
                    
                        }
                    }
                    
                    
                    //print(" 29hf2oh9f ",array![0]["dt"])
                    
//                    if let name = dictionary["name"] as? String
//                    {
//
//                        self._cityName = name.capitalized
//
//                    }
//
//                    if let weather = dictionary["weather"] as? [Dictionary<String, AnyObject>]
//                    {
//
//                        self._description = weather[0]["description"] as! String
//                        self._weatherType = weather[0]["main"] as! String
//                    }
//
//                    if let main = dictionary["main"] as? Dictionary<String, AnyObject>
//                    {
//                        if let currentTemperatureInKelvin = main["temp"] as? Double
//                        {
//                            var tempInCelsius = currentTemperatureInKelvin - 273.15
//                            self._currentTemp = tempInCelsius
//                        }
//
//                    }
                    
                
                }
                completed()
        }
        
        
        
        
    }
}
