//
//  GlobalData.swift
//  Paguda
//
//  Created by Manolescu Mihai Alexandru on 25/02/2018.
//  Copyright © 2018 Manolescu Mihai Alexandru. All rights reserved.
//

import Foundation
import CoreLocation

let currentWeather = WeatherSituation()
var forecasts = [Forecast]()

var debuggingString = [String]()

//singleton
class Location
{
    static var sharedInstance = Location()
    init()
    {
        latitude = 67
        longitute = 64
    }
    
    var latitude: Double! = 67
    var longitute: Double! = 64
    
}

