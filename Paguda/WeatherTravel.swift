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
            getCoordinateFrom(address: text)
            { coordinate, error in
                guard let coordinate = coordinate, error == nil else { return }
                // don't forget to update the UI from the main thread
                DispatchQueue.main.async
                {
                    print("2938gh23gh Coordinates of location name: ",coordinate)
                    self.performSegue(withIdentifier: "find", sender: coordinate)
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier=="find"
        {
            let defVC = segue.destination as! ViewController
            defVC.specificLocation = sender as! CLLocationCoordinate2D
        }
        
        
        
    }
    

}
