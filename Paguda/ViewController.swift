//
//  ViewController.swift
//  Paguda
//
//  Created by Manolescu Mihai Alexandru on 22/02/2018.
//  Copyright © 2018 Manolescu Mihai Alexandru. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
   
    private var gradient = CAGradientLayer()

    @IBOutlet var topView: UIView!
    
    @IBOutlet var tbv: UITableView!
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    
    @IBOutlet var weatherIcon: UIImageView!
    
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUp()
        tbv.dataSource = self
        tbv.delegate = self
        
        updateUI()
        
        
    }

    func updateUI()
    {
        

        //for top main panel:
        currentWeather.downloadDataForCurrentWeather(for: createAPICall(ofType: .weatherAndName, "Bucharest")) {
            self.cityLabel.text = currentWeather._cityName!
            self.tempLabel.text = String(format: "%.1f", currentWeather._currentTemp!) + "°C"
            self.stateLabel.text = currentWeather._description!
            self.timeLabel.text = String("\(currentWeather._date!)")
            
            self.weatherIcon.image = UIImage(named: "\(currentWeather._weatherType!)")
            
            self.tbv.reloadData()
        }
        
        
        //for the tableview forecast:
        downloadDataForForecast(for: createAPICall(ofType: .forecastAndName, "Bucharest"))
        {
            self.tbv.reloadData()
            
            for obj in forecasts
            {
                print("forecasts ",obj._date)
                
            }
            
            print("\n____________\nkkk ",debuggingString," kkk\n___________\n")
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

