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
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
         self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var _eatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    

    func downloadData(completed: DownloadComplete)
    {
        //Download with Alamofire
        let currentURL = URL(string: current_weather_url)!
        
        Alamofire.request(currentURL).responseJSON { response in
            let result = response.result
            print(result)
        }
        completed()
        
    }
    
}
