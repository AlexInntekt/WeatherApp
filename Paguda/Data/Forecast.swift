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

    var _date: String! = "YYYY-MM-DD"
    var _weatherType: String! = ""
    var _description: String! = ""
    var _minTemp: Double! = 0.0
    var _maxTemp: Double! = 0.0
    
        
    
}




func downloadDataForForecast(for specificURL: String,completed: @escaping DownloadComplete) 
{
    forecasts.removeAll()
    
    var arrayWithForecast = [Forecast]()
    
    //Download with Alamofire
    let currentURL = URL(string: specificURL)!
    
    print("IDENTIFIER9304gh3094g URL for forecast:", currentURL)
    
    Alamofire.request(currentURL).responseJSON
        { response in
            let result = response.result
            //print(response)
            
            let numberOfDesiredObjects = 10
            var index = 0
            
            
            
            if let dictionary = result.value as? Dictionary<String, AnyObject>
            {
                
                
                if let list = dictionary["list"] as? [Dictionary<String, AnyObject>]
                {
                    for object in list
                    {
                        
                        var currentForecast = Forecast()
                        currentForecast._date = object["dt_txt"] as! String
                        
                        
                        if let min = object["main"]!["temp_min"] as? Double
                        {
                            currentForecast._minTemp = convertKelvinToCelsius(min)
                        }
                        
                        if let max = object["main"]!["temp_max"] as? Double
                        {
                            currentForecast._maxTemp = convertKelvinToCelsius(max)
                        }
                        
                        //description needed for the image:
                        if let itsWeatherData = object["weather"] as! [Dictionary<String,AnyObject>]!
                        {
                            currentForecast._description = itsWeatherData[0]["main"] as! String
                        }
                        
                        forecasts.append(currentForecast)
                        print("#\(index): ",currentForecast._date)
                        debuggingString.append(currentForecast._date)
                        index += 1
                    }
                    
                }
                
            }
        completed()
            
       }
    
}
