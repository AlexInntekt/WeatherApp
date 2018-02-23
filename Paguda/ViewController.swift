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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(current_weather_url)
        
        setUp()
        tbv.dataSource = self
        tbv.delegate = self
        
        let k = WeatherSituation()
        k.downloadData {
            //Setup the UI to load downloaded data wow
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
        let cell = tbv.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        
        return cell
    }
    
    


}

