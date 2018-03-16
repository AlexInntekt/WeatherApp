//
//  ViewController.swift
//  Paguda
//
//  Created by Manolescu Mihai Alexandru on 22/02/2018.
//  Copyright © 2018 Manolescu Mihai Alexandru. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate
{
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
   
    private var gradient = CAGradientLayer()

    @IBOutlet var topView: UIView!
    
    @IBOutlet var tbv: UITableView!
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    
    @IBOutlet var weatherIcon: UIImageView!
    
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    
    
    
    @IBOutlet var compassButton: UIButton!
    @IBAction func compassButton(_ sender: Any)
    {
        locationAuthStatus()
        updateUI(with: .weatherAndCoordinates, and: .forecastAndCoordinates)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {

        locationAuthStatus()
        updateUI(with: .weatherAndCoordinates, and: .forecastAndCoordinates)
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //this is used for getting the coordinates of the current location:
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        
        setUp()
        
        tbv.dataSource = self
        tbv.delegate = self
        
        
        
        
    }
    
    func locationAuthStatus()
    {
        if(locationManager.location != nil)
        {
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
            {
                currentLocation = locationManager.location!
                Location.sharedInstance.latitude = currentLocation.coordinate.latitude
                Location.sharedInstance.longitute = currentLocation.coordinate.longitude
                
                print("Location.sharedInstance.longitute: : ", Location.sharedInstance.longitute  )
                print("Location.sharedInstance.latitude: ", Location.sharedInstance.latitude  )
            }  else
            {
                locationManager.requestWhenInUseAuthorization()
                locationAuthStatus()
            }
        }
        
        
    }

    func updateUI(with weatherAPItype: callType, and forecastAPItype: callType)
    {
        
  
        //for top main panel:
        //currentWeather.downloadDataForCurrentWeather(for: createAPICall(ofType: .weatherAndName, "Bucharest"))
        currentWeather.downloadDataForCurrentWeather(for: createAPICall(ofType: .weatherAndCoordinates, String(Location.sharedInstance.latitude), String(Location.sharedInstance.longitute) ))
        {
            self.cityLabel.text = currentWeather._cityName!
            self.tempLabel.text = String(format: "%.1f", currentWeather._currentTemp!) + "°C"
            self.stateLabel.text = currentWeather._description!
            self.timeLabel.text = String("\(currentWeather._date!)")
            
            self.weatherIcon.image = UIImage(named: "\(currentWeather._weatherType!)")
            
            
        }
        
        
        //for the tableview forecast:
        downloadDataForForecast(for: createAPICall(ofType: .forecastAndCoordinates, String(Location.sharedInstance.latitude), String(Location.sharedInstance.longitute) ))
        {
            
            
            //for testing:
            for obj in forecasts
            {
                print("forecasts ",obj._description)
                
            }
            
            print("\n____________\nkkk ",debuggingString," kkk\n___________\n")

            self.tbv.reloadData()
        }
        
    }

    func setUp()
    {
        topView.layer.cornerRadius = topView.frame.size.height / 10
        
        
        
        gradient.frame = tbv.superview?.bounds ?? CGRect.null
        //gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        gradient.colors = [UIColor.clear.cgColor,  UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor,  UIColor.clear.cgColor]
        gradient.locations = [0.0, 0.05, 0.15, 0.7, 0.85, 1.0]
        
        tbv.superview?.layer.mask = gradient
        
        tbv.backgroundColor = UIColor.clear
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        gradient.frame = tbv.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbv.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! WeatherCell
        
        cell.dayLabel.text = forecasts[indexPath.row]._date
        cell.minTempLabel.text = String(format: "%.1f", forecasts[indexPath.row]._minTemp) + "°C"
        cell.maxTempLabel.text = String(format: "%.1f", forecasts[indexPath.row]._maxTemp) + "°C"
        cell.weatherIconImage.image = UIImage(named: forecasts[indexPath.row]._description)
        
        return cell
    }
    
    


}

