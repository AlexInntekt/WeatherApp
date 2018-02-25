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
    
    let currentWeather = WeatherSituation()
    let forecast = Forecast()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(current_weather_url)
        
        setUp()
        tbv.dataSource = self
        tbv.delegate = self
        
        updateUI()
        
        
    }

    func updateUI()
    {
        

        //for top main panel:
        currentWeather.downloadDataForCurrentWeather(for: createAPICall(ofType: .weatherAndName, "Bucharest")) {
            self.cityLabel.text = self.currentWeather._cityName
            self.tempLabel.text = String(format: "%.1f", self.currentWeather._currentTemp) + "°C"
            self.stateLabel.text = self.currentWeather._description
            self.timeLabel.text = String("\(self.currentWeather.date)")
            
            self.weatherIcon.image = UIImage(named: "\(self.currentWeather._weatherType!)")
        }
        
        
        //for the tableview forecast:
        forecast.downloadDataForForecast(for: createAPICall(ofType: .forecastAndName, "Bucharest")) {
            self.tbv.reloadData()
        }
    }

    func setUp()
    {
        topView.layer.cornerRadius = topView.frame.size.height / 10
        
        
        
        gradient.frame = tbv.superview?.bounds ?? CGRect.null
        //gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        gradient.colors = [UIColor.clear.cgColor,  UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor,  UIColor.clear.cgColor]
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
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbv.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! WeatherCell
        
        cell.dayLabel.text = forecast._date
        cell.minTempLabel.text = String(format: "%.1f", forecast.minTemp)
        cell.maxTempLabel.text = String(format: "%.1f", forecast.maxTemp)
        cell.weatherIconImage.image = UIImage(named: forecast.description)
        
        return cell
    }
    
    


}

