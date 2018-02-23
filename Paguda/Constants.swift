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

let current_weather_url = "\(BASE_URL)\(lat)60\(long)68\(appID)\(api_key)"

typealias DownloadComplete = () -> ()

//example of api call:
//http://api.openweathermap.org/data/2.5/weather?lat=35&lon=40&APPID=638c10af91af6014fffcc79951d96128
