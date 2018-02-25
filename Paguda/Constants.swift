//
//  Constants.swift
//  Paguda
//
//  Created by Manolescu Mihai Alexandru on 23/02/2018.
//  Copyright © 2018 Manolescu Mihai Alexandru. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let lat =  "lat="
let long = "&lon="
let appID = "&APPID="
let api_key = "638c10af91af6014fffcc79951d96128"

let current_weather_url = "http://api.openweathermap.org/data/2.5/weather?q=Bucharest&APPID=638c10af91af6014fffcc79951d96128"  //"\(BASE_URL)\(lat)60\(long)68\(appID)\(api_key)"
let                   s = "http://api.openweathermap.org/data/2.5/forecast?q=Bucharest&APPID=638c10af91af6014fffcc79951d96128"
let                   c = "http://api.openweathermap.org/data/2.5/weather?lat=35&lon=40&APPID=638c10af91af6014fffcc79951d96128"

typealias DownloadComplete = () -> ()



enum callType {
    case forecastAndName
    case forecastAndCoordinates, weatherAndName, weatherAndCoordinates
}

func createAPICall(ofType call: callType, _ arg: String...) -> String
{
    var customURL = "http://api.openweathermap.org/data/2.5/"
    
    switch call
    {
     case .forecastAndName, .forecastAndCoordinates:
         customURL += "forecast?"
     case .weatherAndName, .weatherAndCoordinates:
         customURL += "weather?"
 
     default:
        print("ERROR IN SWITCH: createAPICall()")
    }
    
    //if the call was done with 2 additional variadic parameters, it means that they are the coordinates of the city:
    if ( (call == .forecastAndCoordinates) || (call == .weatherAndCoordinates) )
    {
        let lattitudeOfLocation = arg[0];
        let longituteOfLocation = arg[1];
        
        print("Variadic param:",arg[0]," ",arg[1])
        customURL += "lat=\(lattitudeOfLocation)&lon=\(longituteOfLocation)"
    }
    else //it means that the call was done with one single additional variadic parameter, that is supposed to be exactly the name of the city:
    {
        if (arg[0] != nil)
        {
            let nameOfCity = arg[0]
            customURL += "q=\(nameOfCity)"
        }
    }
    
    customURL += appID
    customURL += api_key
    print("\n $$$ The url of the API call is: ", customURL)
    return customURL
}



//example of api call:
//http://api.openweathermap.org/data/2.5/weather?lat=35&lon=40&APPID=638c10af91af6014fffcc79951d96128


