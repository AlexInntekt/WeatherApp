//
//  About.swift
//  Paguda
//
//  Created by Manolescu Mihai Alexandru on 10/05/2018.
//  Copyright © 2018 Manolescu Mihai Alexandru. All rights reserved.
//

import UIKit

class About: UIViewController
{
    @IBOutlet var textview: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        textview.text = "·Dev: \n        Manolescu Mihai Alexandru \n   ·Frameworks: \n        -Alamofire\n ·API: \n        -openweathermap.org \n ·Date: \n        2018"
        
        // Do any additional setup after loading the view.
    }

  

 
}
