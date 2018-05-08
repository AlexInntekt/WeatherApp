//
//  WeatherTravel.swift
//  Paguda
//
//  Created by Manolescu Mihai Alexandru on 08/05/2018.
//  Copyright © 2018 Manolescu Mihai Alexandru. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class WeatherTravel: UIViewController
{
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var go: UIButtonX!
    @IBAction func go(_ sender: Any)
    {
        if let text=textField.text
        {
            getCoordinateFrom(address: "Rio de Janeiro, Brazil")
            { coordinate, error in
                guard let coordinate = coordinate, error == nil else { return }
                // don't forget to update the UI from the main thread
                DispatchQueue.main.async
                {
                    print("fn2903gh203hg ",coordinate) // CLLocationCoordinate2D(latitude: -22.910863800000001, longitude: -43.204543600000001)
                    
                }
            }
        }
    }
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        
            
        
        
        
        // Do any additional setup after loading the view.
    }

 
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () )
    {
        CLGeocoder().geocodeAddressString(address) { placemarks, error in
            completion(placemarks?.first?.location?.coordinate, error)
        }
    }

    

}
