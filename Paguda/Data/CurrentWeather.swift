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
    var _cityName: String! = "city name"
    var _date: String! = "Today"
    var _weatherType: String! = "weather type"
    var _description: String! = "description"
    var _currentTemp: Double! = 0.0
    

    
    init()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date! = "Today, \(currentDate)"
    }
    
    //    var cityName: String
    //    {
    //        if _cityName == nil
    //        {
    //            _cityName = "nil"
    //        }
    //        return _cityName
    //    }
//    var date: String
//    {
//        if _date == nil
//        {
//            _date = "nil"
//        }
//
//        let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .long
//            dateFormatter.timeStyle = .none
//
//        let currentDate = dateFormatter.string(from: Date())
//         self._date = "Today, \(currentDate)"
//
//        return _date
//    }
//
//    var weatherType: String
//    {
//        if _weatherType == nil
//        {
//            _weatherType = "nil"
//        }
//        return _weatherType
//    }
//
//    var description: String
//    {
//        if _description == nil
//        {
//            _description = "nil"
//        }
//        return _description
//    }
//
//    var currentTemp: Double
//    {
//        if _currentTemp == nil
//        {
//            _currentTemp = 0.0
//        }
//        return _currentTemp
//    }
    


    func downloadDataForCurrentWeather(for specificURL: String,completed: @escaping DownloadComplete)
    {
        //Download with Alamofire
        let currentURL = URL(string: specificURL)!
        
        Alamofire.request(currentURL).responseJSON
       { response in
            let result = response.result
            //print(response)
            
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
                    
                    if let kelv = main["temp"] as? Double
                    {
                        self._currentTemp = convertKelvinToCelsius(kelv)
                    }
 
                }
      
                
            }
            completed()
        }
        
        
        
        
    }
    
    
    
    
}
